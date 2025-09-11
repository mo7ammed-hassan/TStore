import 'package:t_store/features/checkout/data/models/order_summary_model.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/core/utils/constants/enums.dart';

class CheckoutEntity {
  final String?
      orderId; // created draft id from server (nullable until draft created)
  final List<CartItemEntity> items;
  final double subtotal;
  final double shipping;
  final double discount;
  final double total;
  final OrderStatus? status;

  OrderSummaryModel get orderSummary => OrderSummaryModel(
        subtotal: subtotal,
        discount: discount,
        shipping: shipping,
        total: total,
      );

  CheckoutEntity({
    this.orderId,
    this.status = OrderStatus.unCompleted,
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.discount,
    required this.total,
  });

  CheckoutEntity copyWith({String? orderId}) {
    return CheckoutEntity(
      orderId: orderId ?? this.orderId,
      items: items,
      subtotal: subtotal,
      shipping: shipping,
      discount: discount,
      total: total,
    );
  }

  factory CheckoutEntity.empty() {
    return CheckoutEntity(
      orderId: null,
      items: const [],
      subtotal: 0.0,
      shipping: 0.0,
      discount: 0.0,
      total: 0.0,
      status: OrderStatus.unCompleted,
    );
  }
}
