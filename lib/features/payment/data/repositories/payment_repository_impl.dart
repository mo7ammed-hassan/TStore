import 'package:dartz/dartz.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/features/payment/data/data.dart';
import 'package:t_store/features/payment/data/mappers/payment_details_mappre.dart';
import 'package:t_store/features/payment/domain/domain.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDatasource paymentRemoteDatasource;
  PaymentRepositoryImpl(this.paymentRemoteDatasource);

  @override
  Future<List<CardMethodEntity>> getAvailableMethods() async {
    try {
      return paymentRemoteDatasource.getAvailableMethods();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Either<Failure, PaymentResultEntity>> pay({
    required IPaymentServiceStrategy service,
    required PaymentDetailsEntity? details,
  }) async {
    try {
      final result = await service.pay(details: details?.toModel());
      return Right(result.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
