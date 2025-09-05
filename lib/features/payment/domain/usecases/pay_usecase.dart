import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/errors/failures.dart';
import 'package:t_store/features/payment/core/enums/payment_method.dart';
import 'package:t_store/features/payment/domain/entities/payment_details.dart';
import 'package:t_store/features/payment/domain/entities/payment_result_entity.dart';
import 'package:t_store/features/payment/factories/payment_service_factory.dart';
import 'package:t_store/features/payment/domain/repositories/payment_repository.dart';

class PayUseCase {
  final PaymentRepository _paymentRepository;
  PayUseCase(this._paymentRepository);

  Future<Either<Failure, PaymentResultEntity>> pay({
    required PaymentMethods method,
    required PaymentDetails details,
  }) {
    final service = PaymentServiceFactory.create(method);
    return _paymentRepository.pay(service: service, details: details);
  }
}
