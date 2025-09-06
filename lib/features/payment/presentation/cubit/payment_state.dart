import 'package:t_store/features/payment/domain/entities/payment_method_entity.dart';
import 'package:t_store/features/payment/domain/entities/payment_result_entity.dart';

enum PaymentStateStatus { initial, loading, success, failure }

enum PaymentAction { fetch, selectMethod, processPayment }

class PaymentState {
  final PaymentAction action;
  final PaymentStateStatus status;
  final List<PaymentMethodEntity> methods;
  final PaymentMethodEntity? selectedMethod;
  final PaymentResultEntity? paymentResult;
  final String? message;
  final String? error;

  PaymentState({
    this.action = PaymentAction.fetch,
    this.status = PaymentStateStatus.initial,
    this.methods = const [],
    this.selectedMethod,
    this.paymentResult,
    this.message,
    this.error,
  });

  PaymentState copyWith({
    PaymentAction? action,
    PaymentStateStatus? status,
    List<PaymentMethodEntity>? methods,
    PaymentMethodEntity? selectedMethod,
    PaymentResultEntity? paymentResult,
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
    );
  }
}
