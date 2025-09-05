import 'package:t_store/features/payment/domain/entities/payment_method_entity.dart';

class PaymentState {
  final List<PaymentMethodEntity> methods;
  final PaymentMethodEntity? selected;
  final bool loading;
  final bool successPayment;
  final bool paymentFaliure;
  final bool paymnetProccessLoading;

  PaymentState({
    this.methods = const [],
    this.selected,
    this.loading = false,
    this.paymnetProccessLoading = false,
    this.successPayment = false,
    this.paymentFaliure = false,
  });

  PaymentState copyWith({
    List<PaymentMethodEntity>? methods,
    PaymentMethodEntity? selected,
    bool? loading,
    bool? paymnetProccessLoading,
    bool? successPayment,
    bool? paymentFaliure,
  }) {
    return PaymentState(
      methods: methods ?? this.methods,
      selected: selected ?? this.selected,
      loading: loading ?? this.loading,
      paymnetProccessLoading: paymnetProccessLoading ?? this.paymnetProccessLoading,
      successPayment: successPayment ?? this.successPayment,
      paymentFaliure: paymentFaliure ?? this.paymentFaliure,
    );
  }
}
