import 'package:t_store/features/payment/domain/usecases/get_payment_methods_usecase.dart';
import 'package:t_store/features/payment/domain/usecases/pay_usecase.dart';

class PaymentUsecases {
  final PayUseCase payUseCase;
  final GetPaymentMethodsUsecase getPaymnetMethodUsecase;

  PaymentUsecases(this.payUseCase, this.getPaymnetMethodUsecase);
}
