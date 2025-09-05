import 'package:t_store/features/payment/data/datasources/i_payment_service.dart';
import 'package:t_store/features/payment/data/models/payment_result_model.dart';
import 'package:t_store/features/payment/domain/entities/payment_details.dart';

class CashOnDeliveryPaymentService implements IPaymentService {
  @override
  Future<PaymentResultModel> pay({required PaymentDetails details}) async {
    // COD logic (usually no external SDK)
    return const PaymentResultModel(success: true, message: 'Pay at delivery');
  }
}
