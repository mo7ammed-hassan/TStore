import 'package:t_store/features/payment/data/data.dart';

class CashOnDeliveryPaymentService implements IPaymentServiceStrategy {
  @override
  Future<PaymentResultModel> pay({required PaymentDetailsModel details}) async {
    return const PaymentResultModel(success: true, message: 'Pay at delivery');
  }
}
