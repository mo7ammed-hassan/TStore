import 'package:t_store/features/shop/features/payment/data/models/payment_method.dart';

class PaymentState {
  final List<PaymentMethod> methods;
  final PaymentMethod? selected;
  final bool loading;

  PaymentState({
    this.methods = const [],
    this.selected,
    this.loading = false,
  });

  PaymentState copyWith({
    List<PaymentMethod>? methods,
    PaymentMethod? selected,
    bool? loading,
  }) {
    return PaymentState(
      methods: methods ?? this.methods,
      selected: selected ?? this.selected,
      loading: loading ?? this.loading,
    );
  }
}