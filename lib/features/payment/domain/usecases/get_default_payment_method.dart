import 'package:dartz/dartz.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/features/payment/domain/entities/payment_method_entity.dart';
import 'package:t_store/features/payment/domain/repositories/payment_method_repository.dart';

class GetDefaultPaymentMethod {
  final PaymentMethodRepository _repository;
  GetDefaultPaymentMethod(this._repository);

  Future<Either<Failure, PaymentMethodEntity?>> call(String? customerId) {
    return _repository.getDefaultPaymentMethods(customerId);
  }
}
