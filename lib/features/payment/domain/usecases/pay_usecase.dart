import 'package:dartz/dartz.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/features/payment/core/enums/payment_method.dart';
import 'package:t_store/features/payment/domain/domain.dart';

class PayUseCase {
  final PaymentRepository _paymentRepository;
  PayUseCase(this._paymentRepository);

  Future<Either<Failure, PaymentResultEntity>> pay({
    required PaymentMethods method,
    required PaymentDetailsEntity? details,
    CardFlow? cardFlow = CardFlow.savedCard,
  }) {
    final service = PaymentServiceFactory.create(method, cardFlow: cardFlow);
    return _paymentRepository.pay(service: service, details: details);
  }
}
