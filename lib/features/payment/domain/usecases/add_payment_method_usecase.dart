import 'package:dartz/dartz.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/features/payment/domain/domain.dart';
import 'package:t_store/features/payment/domain/entities/card_details_entity.dart';

class AddPaymentMethodUsecase {
  final PaymentMethodRepository _repository;

  AddPaymentMethodUsecase(this._repository);

  Future<Either<Failure, PaymentMethodEntity>> call({
    required String? customerId,
    required CardDetailsEntity cardDetails,
  }) async {
    return await _repository.addPaymentMethod(customerId, cardDetails);
  }
}
