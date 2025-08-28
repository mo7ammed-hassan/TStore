import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/shop/features/checkout/models/order_summary_model.dart';

sealed class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  final List<CartItemEntity> items;
  final OrderSummaryModel orderSummary;

  CheckoutLoaded({
    required this.items,
    required this.orderSummary,
  });
}

class CheckoutError extends CheckoutState {
  final String message;
  CheckoutError(this.message);
}
