// CheckoutModel <-> CheckoutEntity Mapper Extension
import 'package:t_store/features/checkout/data/models/checkout_model.dart';
import 'package:t_store/features/checkout/domain/entities/checkout_entity.dart';
import 'package:t_store/features/shop/features/cart/data/mapper/cart_item_mapper.dart';

extension CheckoutMapper on CheckoutModel {
  CheckoutEntity toEntity({String? orderId}) {
    return CheckoutEntity(
      orderId: orderId,
      items: items
          .map((e) => e.toEntity())
          .toList(), // CartItemModel -> CartItemEntity
      subtotal: subtotal,
      shipping: shipping,
      discount: discount,
      total: total,
    );
  }
}

extension CheckoutEntityMapper on CheckoutEntity {
  CheckoutModel toModel({String currency = 'EGP'}) {
    return CheckoutModel(
      items: items
          .map((e) => e.toModel())
          .toList(), // CartItemEntity -> CartItemModel
      subtotal: subtotal,
      shipping: shipping,
      discount: discount,
      total: total,
      currency: currency,
    );
  }
}
