import 'package:t_store/features/payment/data/datasources/i_payment_service.dart';
import 'package:t_store/features/payment/data/models/payment_result_model.dart';
import 'package:t_store/features/payment/domain/entities/payment_details.dart';

class VodafoneCashPaymentService implements IPaymentService {
  @override
  Future<PaymentResultModel> pay({required PaymentDetails details}) async {
    return const PaymentResultModel(
      success: true,
      transactionId: 'vf_456',
      message: 'Vodafone Payment Successful',
    );
  }
}
