import 'package:t_store/features/payment/domain/entities/payment_method_entity.dart';
import 'package:t_store/features/payment/domain/entities/payment_result_entity.dart';

abstract class PaymentRepository {
  Future<List<PaymentMethodEntity>> getAvailableMethods();
  Future<PaymentResultEntity> pay({
    required double amount,
    required String methodId,
    required String orderId,
    Map<String, dynamic>? extraData,
  });
}
