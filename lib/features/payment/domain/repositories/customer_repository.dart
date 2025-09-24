import 'package:dartz/dartz.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/features/payment/domain/entities/customer/customer_entity.dart';
// -- Pattern: Repository Pattern & Dependency Inversion Principle (DIP): --
abstract class CustomerRepository {
  Future<Either<Failure, CustomerEntity>> createCustomer(CustomerEntity customer);
  Future<Either<Failure, CustomerEntity>> getCustomer(String customerId);
  Future<Either<Failure, CustomerEntity>> updateCustomer(CustomerEntity customer);
  Future<Either<Failure, void>> deleteCustomer(String? customerId);
}
