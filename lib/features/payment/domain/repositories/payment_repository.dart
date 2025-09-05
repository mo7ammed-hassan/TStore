import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/errors/failures.dart';
import 'package:t_store/features/payment/data/datasources/i_payment_service.dart';
import 'package:t_store/features/payment/domain/entities/payment_details.dart';
import 'package:t_store/features/payment/domain/entities/payment_method_entity.dart';
import 'package:t_store/features/payment/domain/entities/payment_result_entity.dart';

abstract class PaymentRepository {
  Future<List<PaymentMethodEntity>> getAvailableMethods();
  Future<Either<Failure, PaymentResultEntity>> pay({
    required IPaymentService service,
    required PaymentDetails details,
  });
}
