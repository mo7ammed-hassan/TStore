import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:t_store/core/network/api_client.dart';
import 'package:t_store/core/utils/constants/api_constants.dart';
import 'package:t_store/features/payment/data/datasources/payment_method_service/i_payment_method_service.dart';
import 'package:t_store/features/payment/data/models/payment_method/payment_method_model.dart';
import 'package:t_store/features/payment/data/models/payment_method/stripe/stripe_card_method_model.dart';
import 'package:t_store/features/payment/domain/entities/payment_method_entity.dart';

class StripePaymentMethodService implements IPaymentMethodService {
  final ApiClient apiClient;
  StripePaymentMethodService(this.apiClient);

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
    String? customerId,
  ) async {
    if (customerId == null) {
      return null;
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
}
