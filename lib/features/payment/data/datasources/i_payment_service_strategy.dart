import 'package:t_store/features/payment/data/models/payment_details_model.dart';
import 'package:t_store/features/payment/data/models/payment_result_model.dart';

abstract class IPaymentServiceStrategy {
  Future<PaymentResultModel> pay({required PaymentDetailsModel details});
}
