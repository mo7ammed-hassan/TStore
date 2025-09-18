import 'package:t_store/features/payment/domain/domain.dart';
class PaymentUsecases {
  final PayUseCase payUseCase;
  final GetPaymentMethodsUsecase getPaymnetMethodUsecase;
  final GetDefaultPaymentMethod getDefaultPaymentMethod;

  PaymentUsecases(this.payUseCase, this.getPaymnetMethodUsecase, this.getDefaultPaymentMethod);
}
