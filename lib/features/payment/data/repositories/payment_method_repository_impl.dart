import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/features/payment/data/datasources/payment_method_service/i_payment_method_service.dart';
import 'package:t_store/features/payment/domain/entities/payment_method_entity.dart';
import 'package:t_store/features/payment/domain/repositories/payment_method_repository.dart';

class PaymentMethodRepositoryImpl implements PaymentMethodRepository {
  final IPaymentMethodService _methodService;
  PaymentMethodRepositoryImpl(this._methodService);

  @override
  Future<Either<Failure, PaymentMethodEntity>> addPaymentMethod(
    String customerId,
    PaymentMethodEntity method,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deletePaymentMethod(
    String customerId,
    String methodId,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PaymentMethodEntity>>> getPaymentMethods(
    String customerId,
  ) async {
    try {
      final result = await _methodService.getPaymentMethods(customerId);

      final methods = result.map((e) => e.toEntity()).toList();
      return Right(methods);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'There was ana error.'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaymentMethodEntity>> updatePaymentMethod(
      PaymentMethodEntity method) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PaymentMethodEntity?>> getDefaultPaymentMethods(
      String? customerId) async {
    try {
      final method = await _methodService.getDefaultPaymentMethod(customerId);
      if (method != null) {
        return Right(method.toEntity());
      }
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'There was ana error.'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
