import 'package:t_store/features/payment/domain/domain.dart';

class PaymentUsecases {
  final PayUseCase payUseCase;
  final GetPaymentMethodsUsecase getPaymnetMethodUsecase;

  PaymentUsecases(this.payUseCase, this.getPaymnetMethodUsecase);
}
