import 'package:t_store/features/payment/data/data.dart';

class FawryPaymentService implements IPaymentServiceStrategy {
  @override
  Future<PaymentResultModel> pay(
      {required PaymentDetailsModel? details}) async {
    return const PaymentResultModel(success: true, transactionId: 'fw_789');
  }
}
