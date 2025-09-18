import 'package:dartz/dartz.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/features/payment/domain/domain.dart';

class GetDefaultPaymentMethod {
  final PaymentMethodRepository _repository;
  GetDefaultPaymentMethod(this._repository);

  Future<Either<Failure, PaymentMethodEntity?>> call(String? customerId) {
    return _repository.getDefaultPaymentMethods(customerId);
  }
}
