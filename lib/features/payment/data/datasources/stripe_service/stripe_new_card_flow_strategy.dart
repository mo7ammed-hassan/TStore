import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:t_store/core/config/service_locator.dart';
import 'package:t_store/core/network/api_client.dart';
import 'package:t_store/features/payment/data/datasources/customer_service/i_customer_service.dart';
import 'package:t_store/features/payment/data/datasources/i_card_flow_strategy.dart';
import 'package:t_store/features/payment/data/models/card_details_model.dart';
import 'package:t_store/features/payment/data/models/customer/customer_model.dart';
import 'package:t_store/features/payment/data/models/payment_details_model.dart';
import 'package:t_store/features/payment/data/models/stripe/payment_intent_model.dart';
import 'package:t_store/features/payment/data/models/payment_result_model.dart';
import 'package:t_store/features/payment/data/models/payment_user_data.dart';
import 'package:t_store/core/utils/constants/api_constants.dart';
import 'package:t_store/features/personalization/domain/use_cases/update_user_filed_use_case.dart';

class StripeNewCardFlowStrategy implements ICardFlowStrategy {
  final ApiClient dio;
  final ICustomerService customerService;
  StripeNewCardFlowStrategy(this.dio, this.customerService);

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
    await dio.post(
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
    await dio.post(
      '${ApiConstants.customers}/$customerId',
      data: {
        'invoice_settings[default_payment_method]': paymentMethodId,
      },
      headers: {
        'Authorization': "Bearer ${dotenv.env['STRIPE_SECRET_KEY']}",
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );
  }

  Future<PaymentIntentModel> createPaymentIntent({
    required PaymentDetailsModel details,
    String? customerId,
  }) async {
    final data = {
      'amount': (details.amountMinor * 100).toInt(),
      'currency': details.currency,
      'customer': customerId,
    };

    if (details.saveCard) {
      data['setup_future_usage'] =
          'off_session'; // to save payment method to future payment
    }
    final response = await dio.post(
      ApiConstants.paymentIntents,
      data: data,
      headers: {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    final paymentIntent = PaymentIntentModel.fromJson(response.data);
    return paymentIntent;
  }

  Future<PaymentIntent> confirmPayment({
    required String clientSecret,
    required String paymentMethodId,
  }) async {
    return await Stripe.instance.confirmPayment(
      paymentIntentClientSecret: clientSecret,
      data: PaymentMethodParams.cardFromMethodId(
        paymentMethodData:
            PaymentMethodDataCardFromMethod(paymentMethodId: paymentMethodId),
      ),
    );
  }

  @override
  Future<PaymentResultModel> payWithCard(
      {required PaymentDetailsModel details}) async {
    // 1. get customerId
    final customerId = await getOrCreateCustomer(
      customer: CustomerModel(
        id: details.user?.customerId,
        name: details.user?.name,
        email: details.user?.email,
        phone: details.user?.phone,
      ),
    );

    // 2. create PaymentIntent
    final paymentIntent =
        await createPaymentIntent(details: details, customerId: customerId);

    // 3. Create payment method
    final paymentMethod =
        await createPaymentMethod(details.cardDetails, details.user);

    // 4. attach + make default
    if (details.saveCard) {
      await attachAndSetDefaultPaymentMethod(
        customerId: customerId!,
        paymentMethodId: paymentMethod.id,
      );
    }

    // 5. Confirm payment with Stripe SDK
    final paymentResult = await confirmPayment(
      clientSecret: paymentIntent.clientSecret!,
      paymentMethodId: paymentMethod.id,
    );

    return PaymentResultModel(
      success: paymentResult.status == PaymentIntentsStatus.Succeeded,
      transactionId: paymentResult.id,
      paymentIntentId: paymentIntent.id,
      card: paymentMethod.card.brand,
      message: paymentResult.status == PaymentIntentsStatus.Succeeded
          ? 'Stripe Payment Successful'
          : 'Stripe Payment Failed',
    );
  }
}
