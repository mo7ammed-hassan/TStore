import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/features/checkout/data/models/checkout_model.dart';

class OrderEntity {
  final String
      orderId; // created draft id from server (nullable until draft created)
  final String userId;
  final CheckoutModel checkoutModel;
  final String paymentStatus;
  final String orderStatus;
  final Timestamp createdAt;
  final Timestamp? updatedAt;

  OrderEntity({
    required this.orderId,
    required this.userId,
    required this.checkoutModel,
    required this.paymentStatus,
    required this.orderStatus,
    required this.createdAt,
    this.updatedAt,
  });

  OrderEntity copyWith({
    String? orderId,
    String? userId,
    CheckoutModel? checkoutModel,
    String? paymentStatus,
    String? orderStatus,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return OrderEntity(
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      checkoutModel: checkoutModel ?? this.checkoutModel,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      orderStatus: orderStatus ?? this.orderStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
