import 'package:t_store/features/payment/domain/entities/card_method_entity.dart';
import 'package:t_store/features/payment/domain/entities/payment_method/payment_method_entity.dart';
import 'package:t_store/features/payment/domain/entities/payment_result_entity.dart';

enum PaymentStateStatus { initial, loading, success, failure }

enum PaymentAction { fetch, selectMethod, processPayment, fetchDefaultMethod }

class PaymentState {
  final PaymentAction action;
  final PaymentStateStatus status;
  final List<CardMethodEntity> methods;
  final CardMethodEntity? selectedMethod;
  final PaymentResultEntity? paymentResult;
  final PaymentMethodEntity? defaultMethod;
  final String? message;
  final String? error;

  PaymentState({
    this.action = PaymentAction.fetch,
    this.status = PaymentStateStatus.initial,
    this.methods = const [],
    this.selectedMethod,
    this.paymentResult,
    this.defaultMethod,
    this.message,
    this.error,
  });

  PaymentState copyWith({
    PaymentAction? action,
    PaymentStateStatus? status,
    List<CardMethodEntity>? methods,
    CardMethodEntity? selectedMethod,
    PaymentResultEntity? paymentResult,
    PaymentMethodEntity? defaultMethod,
    String? message,
    String? error,
  }) {
    return PaymentState(
      action: action ?? this.action,
      status: status ?? this.status,
      methods: methods ?? this.methods,
      selectedMethod: selectedMethod ?? this.selectedMethod,
      paymentResult: paymentResult ?? this.paymentResult,
      message: message ?? this.message,
      error: error ?? this.error,
      defaultMethod: defaultMethod ?? this.defaultMethod,
    );
  }
}
