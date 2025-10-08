import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:t_store/core/config/service_locator.dart' show getIt;
import 'package:t_store/core/network/api_client.dart';
import 'package:t_store/core/utils/constants/api_constants.dart';
import 'package:t_store/features/payment/core/storage/payment_storage.dart';
import 'package:t_store/features/payment/data/datasources/customer_service/i_customer_service.dart';
import 'package:t_store/features/payment/data/datasources/payment_method_service/i_payment_method_service.dart';
import 'package:t_store/features/payment/data/models/card_details_model.dart';
import 'package:t_store/features/payment/data/models/customer/customer_model.dart';
import 'package:t_store/features/payment/data/models/payment_method/payment_method_model.dart';
import 'package:t_store/features/payment/data/models/payment_method/stripe/stripe_card_method_model.dart';
import 'package:t_store/features/payment/data/models/payment_user_data.dart';
import 'package:t_store/features/payment/domain/entities/payment_method/payment_method_entity.dart';
import 'package:t_store/features/personalization/domain/use_cases/update_user_filed_use_case.dart';

class StripePaymentMethodService implements IPaymentMethodService {
  final ApiClient apiClient;
  final PaymentStorage _paymentStorage;
  final ICustomerService customerService;
  StripePaymentMethodService(
    this.apiClient,
    this._paymentStorage,
    this.customerService,
  );

  @override
  Future<PaymentMethodModel> addPaymentMethod(
    String? customerId,
    CardDetailsModel cardDetails,
  ) async {
    // 1. get customerId
    final customerId = await getOrCreateCustomer(
      customer: CustomerModel(
        id: cardDetails.userData?.customerId,
        name: cardDetails.userData?.name,
        email: cardDetails.userData?.email,
        phone: cardDetails.userData?.phone,
      ),
    );

    // 2. Create payment method
    final paymentMethod =
        await createPaymentMethod(cardDetails, cardDetails.userData);

    // 3. attachAndSetDefaultPaymentMethod
    await attachAndSetDefaultPaymentMethod(
      customerId: customerId!,
      paymentMethodId: paymentMethod.id,
    );

    // 3. Cache the default payment method ID
    await _paymentStorage.saveDefaultMethodId(paymentMethod.id);

    return StripeCardMethodModel.fromPaymentMethod(paymentMethod);
  }

  @override
  Future<void> deletePaymentMethod(String customerId, String methodId) async {
    await apiClient.post(
      '${ApiConstants.paymentMethods}/$methodId/detach',
      headers: {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );
  }

  @override
  Future<List<PaymentMethodModel>> getPaymentMethods(String? customerId) async {
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

  Future<PaymentMethod> createPaymentMethod(
    CardDetailsModel? cardDetails,
    PaymentUserDataModel? user,
  ) async {
    // update card details depend on user card (Custom UI)
    await Stripe.instance.dangerouslyUpdateCardDetails(CardDetails(
      number: cardDetails?.cardNumber,
      expirationMonth: cardDetails?.expMonth,
      expirationYear: cardDetails?.expYear,
      cvc: cardDetails?.cvcCode,
    ));

    final paymentMethod = await Stripe.instance.createPaymentMethod(
      params: PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(
          name: user?.name,
          email: user?.email,
          phone: user?.phone,
          address: user?.address,
        )),
      ),
    );

    return paymentMethod;
  }

  Future<void> attachAndSetDefaultPaymentMethod({
    required String customerId,
    required String paymentMethodId,
  }) async {
    // 1. Attach
    await apiClient.post(
      '${ApiConstants.paymentMethods}/$paymentMethodId/attach',
      data: {
        'customer': customerId,
      },
      headers: {
        'Authorization': "Bearer ${dotenv.env['STRIPE_SECRET_KEY']}",
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    // 2. Set as default
    await apiClient.post(
      '${ApiConstants.customers}/$customerId',
      data: {
        'invoice_settings[default_payment_method]': paymentMethodId,
      },
      headers: {
        'Authorization': "Bearer ${dotenv.env['STRIPE_SECRET_KEY']}",
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    // 3. Cache the default payment method ID
    await _paymentStorage.saveDefaultMethodId(paymentMethodId);
  }

  Future<String?> getOrCreateCustomer({
    required CustomerModel? customer,
  }) async {
    if (customer?.id == null) {
      final newCustomer =
          await customerService.createCustomer(customerData: customer!);
      // store it in db
      await getIt<UpdateUserFiledUseCase>().call(
        params: {
          'stripeCustomerId': newCustomer.id,
        },
      );
      return newCustomer.id;
    }

    final customerData = await customerService.getCustomer(customer?.id);
    return customerData?.id;
  }
}
