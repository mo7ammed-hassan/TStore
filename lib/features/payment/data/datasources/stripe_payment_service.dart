import 'package:t_store/features/payment/data/datasources/i_card_flow_strategy.dart';
import 'package:t_store/features/payment/data/datasources/i_payment_service_strategy.dart';
import 'package:t_store/features/payment/data/models/payment_result_model.dart';
import 'package:t_store/features/payment/domain/entities/payment_details.dart';

class StripePaymentService implements IPaymentServiceStrategy {
  final ICardFlowStrategy cardFlow;
  StripePaymentService(this.cardFlow);

  @override
  Future<PaymentResultModel> pay({required PaymentDetails details}) async {
    return cardFlow.payWithCard(details: details);
  }
}
