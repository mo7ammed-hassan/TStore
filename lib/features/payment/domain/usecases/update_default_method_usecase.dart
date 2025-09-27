import 'package:dartz/dartz.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/features/payment/domain/domain.dart';

class UpdateDefaultPaymentMethodUsecase {
  final PaymentMethodRepository _repository;
  UpdateDefaultPaymentMethodUsecase(this._repository);

  Future<Either<Failure, PaymentMethodEntity>> call({
    required String? customerId,
    required String? methodId,
  }) {
    return _repository.updateDefaultPaymentMethod(customerId, methodId);
  }
}
