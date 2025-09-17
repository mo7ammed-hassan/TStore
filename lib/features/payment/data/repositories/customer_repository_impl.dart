import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/features/payment/data/datasources/customer_service/i_customer_service.dart';
import 'package:t_store/features/payment/data/mappers/customer_mapper.dart';
import 'package:t_store/features/payment/domain/entities/customer_entity.dart';
import 'package:t_store/features/payment/domain/repositories/customer_repository.dart';
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
}
