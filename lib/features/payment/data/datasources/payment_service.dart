import 'package:t_store/features/payment/domain/entities/payment_result_entity.dart';

abstract class IPaymentService {
  Future<PaymentResultEntity> pay({
    required double amount,
    required String orderId,
    Map<String, dynamic>? extraData,
  });
}
