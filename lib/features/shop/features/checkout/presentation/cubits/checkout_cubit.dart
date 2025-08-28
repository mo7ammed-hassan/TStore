import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/shop/features/checkout/models/order_summary_model.dart';
import 'package:t_store/features/shop/features/checkout/presentation/cubits/checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  void loadCheckout(List<CartItemEntity> items) {
    emit(CheckoutLoading());

    try {
      final subtotal = items.fold(0.0, (sum, item) => sum + item.totalPrice);

      final discount = _calculateDiscount(items);
      final shipping = _calculateShipping(items);
      final total = subtotal - discount + shipping;

      final orderSummary = OrderSummaryModel(
        subtotal: subtotal,
        discount: discount,
        shipping: shipping,
        total: total,
      );

      emit(CheckoutLoaded(items: items, orderSummary: orderSummary));
    } catch (e) {
      emit(CheckoutError(e.toString()));
    }
  }

  double _calculateDiscount(List<CartItemEntity> items) {
    // logic for coupon/discount
    return 0.0;
  }

  double _calculateShipping(List<CartItemEntity> items) {
    // logic for shipping
    return 10.0; // example
  }
}
