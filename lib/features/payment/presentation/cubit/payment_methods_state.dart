import 'package:t_store/features/payment/domain/entities/card_method_entity.dart';
import 'package:t_store/features/payment/domain/entities/payment_method/payment_method_entity.dart';
import 'package:t_store/features/payment/domain/entities/payment_result_entity.dart';

enum PaymentMethodStateStatus { initial, loading, success, failure }

enum PaymentMethodAction {
  fetch,
  selectMethod,
  processPayment,
  fetchDefaultMethod,
  updateDefaultMethod
}

class PaymentMethodState {
  final PaymentMethodAction action;
  final PaymentMethodStateStatus status;
  final List<PaymentMethodEntity> methods;
  final CardMethodEntity? selectedMethod;
  final PaymentResultEntity? paymentResult;
  final PaymentMethodEntity? defaultMethod;
  final String? message;
  final String? error;
  final String? updatedMethodId;

  PaymentMethodState({
    this.action = PaymentMethodAction.fetch,
    this.status = PaymentMethodStateStatus.initial,
    this.methods = const [],
    this.selectedMethod,
    this.paymentResult,
    this.defaultMethod,
    this.message,
    this.error,
    this.updatedMethodId,
  });

  PaymentMethodState copyWith({
    PaymentMethodAction? action,
    PaymentMethodStateStatus? status,
    List<PaymentMethodEntity>? methods,
    CardMethodEntity? selectedMethod,
    PaymentResultEntity? paymentResult,
    PaymentMethodEntity? defaultMethod,
    String? updatedMethodId,
    String? message,
    String? error,
  }) {
    return PaymentMethodState(
      action: action ?? this.action,
      status: status ?? this.status,
      methods: methods ?? this.methods,
      selectedMethod: selectedMethod ?? this.selectedMethod,
      paymentResult: paymentResult ?? this.paymentResult,
      message: message ?? this.message,
      error: error ?? this.error,
      defaultMethod: defaultMethod ?? this.defaultMethod,
      updatedMethodId: updatedMethodId ?? this.updatedMethodId,
    );
  }
}
