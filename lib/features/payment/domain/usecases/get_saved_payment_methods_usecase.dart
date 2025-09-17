import 'package:dartz/dartz.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/features/payment/domain/entities/payment_method_entity.dart';
import 'package:t_store/features/payment/domain/repositories/payment_method_repository.dart';

class GetSavedPaymentMethodsUsecase {
  final PaymentMethodRepository _repository;
  GetSavedPaymentMethodsUsecase(this._repository);

  Future<Either<Failure, List<PaymentMethodEntity>>> call(String customerId) {
    return _repository.getPaymentMethods(customerId);
  }
}
