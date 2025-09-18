import 'package:dartz/dartz.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/features/payment/domain/domain.dart';


class GetSavedPaymentMethodsUsecase {
  final PaymentMethodRepository _repository;
  GetSavedPaymentMethodsUsecase(this._repository);

  Future<Either<Failure, List<PaymentMethodEntity>>> call(String customerId) {
    return _repository.getPaymentMethods(customerId);
  }
}
