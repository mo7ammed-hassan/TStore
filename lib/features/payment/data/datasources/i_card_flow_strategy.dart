import 'package:t_store/features/payment/data/models/models.dart';

abstract class ICardFlowStrategy {
  Future<PaymentResultModel> payWithCard(
      {required PaymentDetailsModel details});
}
