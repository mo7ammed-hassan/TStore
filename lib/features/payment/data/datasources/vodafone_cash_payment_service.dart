import 'package:t_store/features/payment/data/data.dart';

class VodafoneCashPaymentService implements IPaymentServiceStrategy {
  @override
  Future<PaymentResultModel> pay(
      {required PaymentDetailsModel? details}) async {
    return const PaymentResultModel(
      success: true,
      transactionId: 'vf_456',
      message: 'Vodafone Payment Successful',
    );
  }
}
