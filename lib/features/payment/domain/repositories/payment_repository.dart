import 'package:dartz/dartz.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/features/payment/data/datasources/i_payment_service_strategy.dart';
import 'package:t_store/features/payment/domain/domain.dart';

abstract class PaymentRepository {
  Future<List<CardMethodEntity>> getAvailableMethods();
  Future<Either<Failure, PaymentResultEntity>> pay({
    required IPaymentServiceStrategy service,
    required PaymentDetailsEntity? details,
  });
}
