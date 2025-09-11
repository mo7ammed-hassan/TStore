import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/features/checkout/domain/entities/checkout_entity.dart';
import 'package:t_store/features/personalization/pages/address/domain/entities/address_entity.dart';

class OrderEntity {
  final String
      orderId; // created draft id from server (nullable until draft created)
  final String userId;
  final CheckoutEntity checkoutModel;
  final String? paymentIntentId;
  final String? transactionId;
  final AddressEntity? shippingAddress;
  final String paymentStatus;
  final String orderStatus;
  final Timestamp createdAt;
  final Timestamp? updatedAt;

  OrderEntity({
    required this.orderId,
    required this.userId,
    required this.checkoutModel,
    this.paymentIntentId,
    this.transactionId,
    required this.paymentStatus,
    required this.orderStatus,
    required this.createdAt,
    required this.shippingAddress,
    this.updatedAt,
  });

  OrderEntity copyWith({
    String? orderId,
    String? userId,
    CheckoutEntity? checkoutModel,
    String? paymentIntentId,
    String? transactionId,
    String? paymentStatus,
    String? orderStatus,
    AddressEntity? shippingAddress,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return OrderEntity(
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      checkoutModel: checkoutModel ?? this.checkoutModel,
      paymentIntentId: paymentIntentId ?? this.paymentIntentId,
      transactionId: transactionId ?? this.transactionId,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      orderStatus: orderStatus ?? this.orderStatus,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory OrderEntity.empty() {
    return OrderEntity(
      orderId: '',
      userId: '',
      checkoutModel: CheckoutEntity.empty(),
      paymentIntentId: null,
      transactionId: null,
      paymentStatus: '',
      orderStatus: '',
      createdAt: Timestamp.now(),
      shippingAddress: AddressEntity.empty(),
      updatedAt: null,
    );
  }
}
