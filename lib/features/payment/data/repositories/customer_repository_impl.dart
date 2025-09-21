import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/features/payment/data/data.dart';
import 'package:t_store/features/payment/domain/domain.dart';

// -- Pattern: Adapter Pattern + Repository Pattern.--
// -- why Adapter => convert data that comming from entity to model
class CustomerRepositoryImpl implements CustomerRepository {
  final ICustomerService _customerService;
  CustomerRepositoryImpl(this._customerService);

  @override
  Future<Either<Failure, CustomerEntity>> createCustomer(
      CustomerEntity customer) async {
    try {
      final customerData = await _customerService.createCustomer(
        customerData: customer.toModel(),
      );

      return Right(customerData.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CustomerEntity>> getCustomer(String customerId) async {
    try {
      final customerData = await _customerService.getCustomer(customerId);

      if (customerData == null) return Left(NotFoundFailure());
      return Right(customerData.toEntity());
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'There was ana error.'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CustomerEntity>> updateCustomer(
      CustomerEntity customer) async {
    try {
      final customerData = await _customerService.updateCustomer(
        customerData: customer.toModel(),
      );

      return Right(customerData.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCustomer(String customerId) async {
    try {
      await (_customerService as StripeCustomerService)
          .deleteCustomer(customerId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'There was an error.'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
