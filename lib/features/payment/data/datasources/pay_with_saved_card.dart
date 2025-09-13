import 'package:t_store/features/payment/data/datasources/i_card_flow_strategy.dart';
import 'package:t_store/features/payment/data/models/payment_result_model.dart';
import 'package:t_store/features/payment/domain/entities/payment_details.dart';

class PayWithSavedCardStrategy implements ICardFlowStrategy {
  @override
  Future<PaymentResultModel> payWithCard({required PaymentDetails details}) {
    throw UnimplementedError();
  }
  
  
}