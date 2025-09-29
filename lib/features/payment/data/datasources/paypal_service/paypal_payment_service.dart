import 'package:t_store/features/payment/data/data.dart';

class PayPalPaymentService implements IPaymentServiceStrategy {
  @override
  Future<PaymentResultModel> pay({required PaymentDetailsModel? details}) async {
    return const PaymentResultModel(
      success: true,
      transactionId: 'py_456',
      message: 'PayPal Payment Successful',
    );
  }
}
