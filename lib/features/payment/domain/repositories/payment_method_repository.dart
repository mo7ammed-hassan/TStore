import 'package:dartz/dartz.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/features/payment/domain/entities/card_details_entity.dart';
import 'package:t_store/features/payment/domain/entities/payment_method/payment_method_entity.dart';

abstract class PaymentMethodRepository {
  Future<Either<Failure, PaymentMethodEntity>> addPaymentMethod(
    String? customerId,
    CardDetailsEntity cardDetails,
  );

  Future<Either<Failure, PaymentMethodEntity>> updatePaymentMethod(
    PaymentMethodEntity method,
  );

  Future<Either<Failure, PaymentMethodEntity>> updateDefaultPaymentMethod(
    String? customerId,
    String? methodId,
  );

  Future<Either<Failure, void>> deletePaymentMethod(
    String customerId,
    String methodId,
  );

  Future<Either<Failure, List<PaymentMethodEntity>>> getPaymentMethods(
    String customerId,
  );

  Future<Either<Failure, PaymentMethodEntity?>> getDefaultPaymentMethods(
    String? customerId,
  );
}
