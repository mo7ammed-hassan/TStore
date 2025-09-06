import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/features/checkout/data/models/checkout_model.dart';
import 'package:t_store/features/personalization/pages/address/data/models/address_model.dart';

class OrderModel {
  final String?
      orderId; // created draft id from server (nullable until draft created)
  final String? userId;
  final AddressModel? shippingAddress;
  final CheckoutModel checkoutModel;
  final String? paymentIntentId;
  final String? transactionId;
  final String? paymentStatus;
  final String? orderStatus;
  final Timestamp createdAt;
  final Timestamp? updatedAt;

  OrderModel({
    this.orderId,
    this.userId,
    this.shippingAddress,
    required this.checkoutModel,
    this.paymentIntentId,
    this.transactionId,
    required this.paymentStatus,
    required this.orderStatus,
    required this.createdAt,
    this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'] as String?,
      userId: json['userId'] as String?,
      shippingAddress: AddressModel.fromJson(
          json['shippingAddress'] as Map<String, dynamic>),
      checkoutModel:
          CheckoutModel.fromJson(json['checkoutModel'] as Map<String, dynamic>),
      transactionId: json['transactionId'] ?? '',
      paymentIntentId: json['paymentIntentId'] ?? '',
      paymentStatus: json['paymentStatus'] as String,
      orderStatus: json['orderStatus'] as String,
      createdAt: json['createdAt'] as Timestamp,
      updatedAt: json['updatedAt'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'userId': userId,
      'shippingAddress': shippingAddress?.toJson(),
      'checkoutModel': checkoutModel.toJson(),
      'transactionId': transactionId,
      'paymentIntentId': paymentIntentId,
      'paymentStatus': paymentStatus,
      'orderStatus': orderStatus,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  Map<String, dynamic> toUpdateMap() {
    final map = <String, dynamic>{};
    if (orderStatus != null) map['orderStatus'] = orderStatus;
    if (paymentStatus != null) map['paymentStatus'] = paymentStatus;
    if (transactionId != null) map['transactionId'] = transactionId;
    if (paymentIntentId != null) map['paymentIntentId'] = paymentIntentId;
    if (updatedAt != null) map['updatedAt'] = updatedAt;
    return map;
  }
}
