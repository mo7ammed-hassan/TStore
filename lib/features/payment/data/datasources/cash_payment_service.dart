import 'package:t_store/core/utils/constants/enums.dart';
import 'package:t_store/features/payment/data/data.dart';

class CashOnDeliveryPaymentService implements IPaymentServiceStrategy {
  @override
  Future<PaymentResultModel> pay(
      {required PaymentDetailsModel? details}) async {
    return const PaymentResultModel(
      success: true,
      message: 'Pay On delivery',
      paymentStatus: PaymentStatus.cashPayment,
      card: 'Cash on Delivery',
    );
  }
}
