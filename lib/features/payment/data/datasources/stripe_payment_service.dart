import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:t_store/core/network/api_client.dart';
import 'package:t_store/features/payment/data/datasources/i_payment_service.dart';
import 'package:t_store/features/payment/data/models/credit_card_details_model.dart';
import 'package:t_store/features/payment/data/models/payment_intent_model.dart';
import 'package:t_store/features/payment/data/models/payment_result_model.dart';
import 'package:t_store/features/payment/data/models/payment_use_data.dart';
import 'package:t_store/features/payment/domain/entities/payment_details.dart';
import 'package:t_store/core/utils/constants/api_constants.dart';

class StripePaymentService implements IPaymentService {
  final ApiClient dio;
  StripePaymentService(this.dio);

  Future<PaymentMethod> createPaymentMethod(
    CreditCardDetailsModel? cardDetails,
    PaymentUserDataModel? user,
  ) async {
    // update card details depend on user card (Custom UI)
    await Stripe.instance.dangerouslyUpdateCardDetails(CardDetails(
      number: cardDetails?.cardNumber,
      expirationMonth: cardDetails?.expMonth,
      expirationYear: cardDetails?.expYear,
      cvc: cardDetails?.cvvCode,
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

  Future<PaymentIntentModel> createPaymentIntent(
      {required PaymentDetails details}) async {
    final response = await dio.post(
      ApiConstants.paymentIntents,
      data: {
        'amount': (details.amountMinor * 100).toInt(),
        'currency': details.currency,
      },
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
  Future<PaymentResultModel> pay({required PaymentDetails details}) async {
    // 1. Call backend to create
    final paymentIntent = await createPaymentIntent(details: details);

    // 2. Create payment method
    final paymentMethod =
        await createPaymentMethod(details.cardDetails, details.user);

    // 3. Confirm payment with Stripe SDK
    final paymentResult = await confirmPayment(
      clientSecret: paymentIntent.clientSecret!,
      paymentMethodId: paymentMethod.id,
    );

    return PaymentResultModel(
      success: paymentResult.status == PaymentIntentsStatus.Succeeded,
      transactionId: paymentResult.id,
      paymentIntentId: paymentIntent.id,
      message: paymentResult.status == PaymentIntentsStatus.Succeeded
          ? 'Stripe Payment Successful'
          : 'Stripe Payment Failed',
    );
  }
}
