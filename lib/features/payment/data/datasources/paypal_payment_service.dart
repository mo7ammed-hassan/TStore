import 'package:t_store/features/payment/data/datasources/i_payment_service_strategy.dart';
import 'package:t_store/features/payment/data/models/payment_result_model.dart';
import 'package:t_store/features/payment/domain/entities/payment_details.dart';

class PayPalPaymentService implements IPaymentServiceStrategy {
  @override
  Future<PaymentResultModel> pay({required PaymentDetails details}) async {
    return const PaymentResultModel(
      success: true,
      transactionId: 'py_456',
      message: 'PayPal Payment Successful',
    );
  }
}
