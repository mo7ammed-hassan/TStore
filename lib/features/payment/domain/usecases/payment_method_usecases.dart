import 'package:t_store/features/payment/domain/usecases/get_default_payment_method.dart';
import 'package:t_store/features/payment/domain/usecases/get_saved_payment_methods_usecase.dart';
import 'package:t_store/features/payment/domain/usecases/update_default_method_usecase.dart';

class PaymentMethodUsecases {
  final GetSavedPaymentMethodsUsecase getPaymentMethods;
  final GetDefaultPaymentMethod defaultMethodUsecase;
  final UpdateDefaultPaymentMethodUsecase updateDefaultMethodUsecase;

  PaymentMethodUsecases(
    this.getPaymentMethods,
    this.defaultMethodUsecase,
    this.updateDefaultMethodUsecase,
  );
}
