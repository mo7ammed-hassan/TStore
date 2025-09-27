import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:t_store/core/network/api_client.dart';
import 'package:t_store/core/utils/constants/api_constants.dart';
import 'package:t_store/features/payment/core/storage/payment_storage.dart';
import 'package:t_store/features/payment/data/datasources/payment_method_service/i_payment_method_service.dart';
import 'package:t_store/features/payment/data/models/payment_method/payment_method_model.dart';
import 'package:t_store/features/payment/data/models/payment_method/stripe/stripe_card_method_model.dart';
import 'package:t_store/features/payment/domain/entities/payment_method/payment_method_entity.dart';

class StripePaymentMethodService implements IPaymentMethodService {
  final ApiClient apiClient;
  final PaymentStorage _paymentStorage;
  StripePaymentMethodService(this.apiClient, this._paymentStorage);

  @override
  Future<PaymentMethodModel> addPaymentMethod(
    String customerId,
    PaymentMethodModel method,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<void> deletePaymentMethod(String customerId, String methodId) {
    throw UnimplementedError();
  }

  @override
  Future<List<PaymentMethodModel>> getPaymentMethods(String customerId) async {
    final response = await apiClient.get(
      ApiConstants.getCustomerPaymentMethods(customerId: customerId),
      headers: {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    final List<dynamic> data = response.data['data'];
    final methods = data.map((e) => StripeCardMethodModel.fromJson(e)).toList();

    return methods;
  }

  @override
  Future<PaymentMethodModel> updatePaymentMethod(PaymentMethodModel method) {
    throw UnimplementedError();
  }

  @override
  Future<PaymentMethodModel<PaymentMethodEntity>?> getDefaultPaymentMethod(
    String? customerId, {
    Duration cacheDuration = const Duration(minutes: 10),
  }) async {
    if (customerId == null) {
      return null;
    }

    // Check cache
    final cachedId = _paymentStorage.getDefaultMethodId();
    final lastFetchedAt = _paymentStorage.getLastFetchedAt();

    if (cachedId != null && lastFetchedAt != null) {
      final isFresh = DateTime.now().difference(lastFetchedAt) < cacheDuration;
      if (isFresh) {
        // Fetch payment method details using cached ID
        final paymentMethodResponse = await apiClient.get(
          '${ApiConstants.paymentMethods}/$cachedId',
          headers: {
            'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        );
        return StripeCardMethodModel.fromJson(paymentMethodResponse.data);
      }
    }

    // 1. Get customer details
    final customerResponse = await apiClient.get(
      '${ApiConstants.customers}/$customerId',
      headers: {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    final defaultPaymentMethodId =
        customerResponse.data['invoice_settings']?['default_payment_method'];

    if (defaultPaymentMethodId == null) {
      return null;
    }

    // Cache the default payment method ID
    await _paymentStorage.saveDefaultMethodId(defaultPaymentMethodId);

    // 2. Retrieve payment method details
    final paymentMethodResponse = await apiClient.get(
      '${ApiConstants.paymentMethods}/$defaultPaymentMethodId',
      headers: {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    // 3. Convert response to Stripe PaymentMethod
    return StripeCardMethodModel.fromJson(paymentMethodResponse.data);
  }

  @override
  Future<PaymentMethodModel> updateDefaultPaymentMethod(
    String? customerId,
    String? methodId,
  ) async {
    // 1. Set as default
    await apiClient.post(
      '${ApiConstants.customers}/$customerId',
      data: {
        'invoice_settings[default_payment_method]': methodId,
      },
      headers: {
        'Authorization': "Bearer ${dotenv.env['STRIPE_SECRET_KEY']}",
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    // 3. Fetch payment method details using cached ID
    final paymentMethodResponse = await apiClient.get(
      '${ApiConstants.paymentMethods}/$methodId',
      headers: {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    // . Cache the default payment method ID
    await _paymentStorage.updateDefaultMethodId(methodId);

    return StripeCardMethodModel.fromJson(paymentMethodResponse.data);
  }
}
