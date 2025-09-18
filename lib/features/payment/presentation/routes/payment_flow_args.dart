import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/payment/core/enums/payment_entry_point.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';

class PaymentFlowArgs {
  final OrderEntity? order;
  final List<CartItemEntity>? items;
  final ProductEntity? product;
  final bool removeCartItems;
  final PaymentEntryPoint? entryPoint;

  PaymentFlowArgs({
    this.order,
    this.items,
    this.product,
    this.removeCartItems = false,
    this.entryPoint,
  });
}
