import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/features/payment/core/storage/payment_storage.dart';
import 'package:t_store/features/payment/data/data.dart';
import 'package:t_store/features/payment/data/mappers/payment_details_mappre.dart';
import 'package:t_store/features/payment/domain/domain.dart';
import 'package:t_store/features/payment/domain/entities/card_details_entity.dart';

class PaymentMethodRepositoryImpl implements PaymentMethodRepository {
  final IPaymentMethodService _methodService;
  PaymentMethodRepositoryImpl(this._methodService);

  @override
  Future<Either<Failure, PaymentMethodEntity>> addPaymentMethod(
    String? customerId,
    CardDetailsEntity cardDetails,
  ) async {
    try {
      final method = await _methodService.addPaymentMethod(
        customerId,
        cardDetails.toModel(),
      );

      return Right(method.toEntity());
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'There was ana error.'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePaymentMethod(
    String customerId,
    String methodId,
  ) async {
    try {
      await _methodService.deletePaymentMethod(customerId, methodId);
      
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'There was ana error.'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PaymentMethodEntity>>> getPaymentMethods(
    String? customerId,
  ) async {
    try {
      if (customerId == null || customerId.isEmpty) {
        return const Right([]);
      }
      final defaultMethodId = PaymentStorage.instance.getDefaultMethodId();

      final result = await _methodService.getPaymentMethods(customerId);

      final methods = result.map((e) {
        if (e.id == defaultMethodId) {
          PaymentMethodEntity updatedcard =
              e.toEntity().copyWith(defaultMethod: true);
          return updatedcard;
        }
        return e.toEntity();
      }).toList();

      return Right(methods);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'There was ana error.'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaymentMethodEntity>> updatePaymentMethod(
    PaymentMethodEntity method,
  ) {
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

  @override
  Future<Either<Failure, PaymentMethodEntity>> updateDefaultPaymentMethod(
    String? customerId,
    String? methodId,
  ) async {
    try {
      final method =
          await _methodService.updateDefaultPaymentMethod(customerId, methodId);
      return Right(method.toEntity());
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'There was ana error.'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
