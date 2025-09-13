import 'package:dartz/dartz.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/features/payment/data/datasources/i_payment_service_strategy.dart';
import 'package:t_store/features/payment/data/datasources/payment_remote_datasource.dart';
import 'package:t_store/features/payment/data/mappers/payment_result_mapper.dart';
import 'package:t_store/features/payment/domain/entities/payment_details.dart';
import 'package:t_store/features/payment/domain/entities/payment_method_entity.dart';
import 'package:t_store/features/payment/domain/entities/payment_result_entity.dart';
import 'package:t_store/features/payment/domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDatasource paymentRemoteDatasource;
  PaymentRepositoryImpl(this.paymentRemoteDatasource);

  @override
  Future<List<PaymentMethodEntity>> getAvailableMethods() async {
    try {
      return paymentRemoteDatasource.getAvailableMethods();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Either<Failure, PaymentResultEntity>> pay({
    required IPaymentServiceStrategy service,
    required PaymentDetails details,
  }) async {
    try {
      final result = await service.pay(details: details);
      return Right(result.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
