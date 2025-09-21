import 'package:dartz/dartz.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/features/payment/domain/domain.dart';

class DeleteCustomerUsecase {
  final CustomerRepository _repository;
  DeleteCustomerUsecase(this._repository);

  Future<Either<Failure, void>> call(String? customerId) {
    return _repository.deleteCustomer(customerId!);
  }
}
