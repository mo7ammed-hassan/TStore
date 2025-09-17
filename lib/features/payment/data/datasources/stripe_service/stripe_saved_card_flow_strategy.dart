import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:t_store/core/network/api_client.dart';
import 'package:t_store/features/payment/data/datasources/customer_service/i_customer_service.dart';
import 'package:t_store/features/payment/data/datasources/i_card_flow_strategy.dart';
import 'package:t_store/features/payment/data/models/payment_intent_model.dart';
import 'package:t_store/features/payment/data/models/payment_result_model.dart';
import 'package:t_store/features/payment/domain/entities/payment_details.dart';
import 'package:t_store/core/utils/constants/api_constants.dart';

class StripeSavedCardFlowStrategy implements ICardFlowStrategy {
  final ApiClient dio;
  final ICustomerService customerService;
  StripeSavedCardFlowStrategy(this.dio, this.customerService);

  Future<PaymentIntentModel> createPaymentIntent(
      {required PaymentDetails details}) async {
    final response = await dio.post(
      ApiConstants.paymentIntents,
      data: {
        'amount': (details.amountMinor * 100).toInt(),
        'currency': details.currency,
        'customer': details.user?.customerId,
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
    required String cvc,
  }) async {
    return await Stripe.instance.confirmPayment(
      paymentIntentClientSecret: clientSecret,
      data: PaymentMethodParams.cardFromMethodId(
        paymentMethodData: PaymentMethodDataCardFromMethod(
          paymentMethodId: paymentMethodId,
          cvc: cvc,
        ),
      ),
    );
  }

  @override
  Future<PaymentResultModel> payWithCard({
    required PaymentDetails details,
  }) async {
    final paymentIntent = await createPaymentIntent(details: details);

    final paymentResult = await confirmPayment(
      clientSecret: paymentIntent.clientSecret!,
      paymentMethodId: details.paymentMethodId!,
      cvc: details.cvc!,
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
