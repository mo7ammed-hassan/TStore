import 'package:t_store/features/payment/data/data.dart';

class StripePaymentService implements IPaymentServiceStrategy {
  final ICardFlowStrategy cardFlow;
  StripePaymentService(this.cardFlow);

  @override
  Future<PaymentResultModel> pay({required PaymentDetailsModel? details}) async {
    return cardFlow.payWithCard(details: details);
  }
}
