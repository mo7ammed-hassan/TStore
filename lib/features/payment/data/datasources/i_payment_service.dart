import 'package:t_store/features/payment/data/models/payment_result_model.dart';
import 'package:t_store/features/payment/domain/entities/payment_details.dart';

abstract class IPaymentService {
  Future<PaymentResultModel> pay({required PaymentDetails details});
}
