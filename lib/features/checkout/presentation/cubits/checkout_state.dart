import 'package:t_store/features/checkout/domain/entities/checkout_entity.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';

class CheckoutState {
  final bool isLoading;
  final CheckoutEntity? checkoutData;
  final String message;
  final bool createOrderLoading;
  final bool createOrderSuccess;
  final OrderEntity? order;

  CheckoutState({
    this.isLoading = false,
    this.checkoutData,
    this.order,
    this.message = '',
    this.createOrderLoading = false,
    this.createOrderSuccess = false,
  });

  // CopyWith method for immutability
  CheckoutState copyWith({
    bool? isLoading,
    CheckoutEntity? checkoutData,
    String? message,
    OrderEntity? order,
    bool? createOrderLoading,
    bool? createOrderSuccess,
  }) {
    return CheckoutState(
      isLoading: isLoading ?? this.isLoading,
      checkoutData: checkoutData ?? this.checkoutData,
      message: message ?? this.message,
      order: order ?? this.order,
      createOrderLoading: createOrderLoading ?? this.createOrderLoading,
      createOrderSuccess: createOrderSuccess ?? this.createOrderSuccess,
    );
  }
}
