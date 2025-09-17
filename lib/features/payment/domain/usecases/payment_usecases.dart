import 'package:t_store/features/payment/domain/usecases/get_default_payment_method.dart';
import 'package:t_store/features/payment/domain/usecases/get_payment_methods_usecase.dart';
import 'package:t_store/features/payment/domain/usecases/pay_usecase.dart';

class PaymentUsecases {
  final PayUseCase payUseCase;
  final GetPaymentMethodsUsecase getPaymnetMethodUsecase;
  final GetDefaultPaymentMethod getDefaultPaymentMethod;

  PaymentUsecases(this.payUseCase, this.getPaymnetMethodUsecase, this.getDefaultPaymentMethod);
}
