import 'package:t_store/features/payment/domain/entities/payment_method_entity.dart';

abstract class PaymentMethodsState {}

class PaymentMethodsInitial extends PaymentMethodsState {}

class PaymentMethodsLoading extends PaymentMethodsState {}

class PaymentMethodsLoaded extends PaymentMethodsState {
  final List<PaymentMethodEntity> methods;
  PaymentMethodsLoaded(this.methods);
}

class PaymentMethodsError extends PaymentMethodsState {
  final String message;
  PaymentMethodsError(this.message);
}
