import 'package:dartz/dartz.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/features/payment/domain/domain.dart';

class DeletePaymentMethodUsecase {
  final PaymentMethodRepository _repository;

  DeletePaymentMethodUsecase(this._repository);

  Future<Either<Failure, void>> call({
    required String customerId,
    required String methodId,
  }) async {
    return await _repository.deletePaymentMethod(customerId, methodId);
  }
}
