import 'package:t_store/features/shop/features/cart/data/models/cart_item_model.dart';

class CheckoutModel {
  final List<CartItemModel> items;
  final double subtotal;
  final double shipping;
  final double discount;
  final double total;
  final String currency;

  CheckoutModel({
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.discount,
    required this.total,
    required this.currency,
  });

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return CheckoutModel(
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      subtotal: (json['subtotal'] as num).toDouble(),
      shipping: (json['shipping'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      currency: json['currency'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((e) => e.toJson()).toList(),
      'total': total,
      'discount': discount,
      'subtotal': subtotal,
      'currency': 'EGP',
      'shipping': shipping,
    };
  }
}
