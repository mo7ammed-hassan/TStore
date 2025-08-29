import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/features/checkout/data/models/checkout_model.dart';

class OrderModel {
  final String?
      orderId; // created draft id from server (nullable until draft created)
  final String? userId;
  final CheckoutModel checkoutModel;
  final String paymentStatus;
  final String orderStatus;
  final Timestamp createdAt;
  final Timestamp? updatedAt;

  OrderModel({
    this.orderId,
    this.userId,
    required this.checkoutModel,
    required this.paymentStatus,
    required this.orderStatus,
    required this.createdAt,
    this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'] as String?,
      userId: json['userId'] as String?,
      checkoutModel:
          CheckoutModel.fromJson(json['checkoutModel'] as Map<String, dynamic>),
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
      'checkoutModel': checkoutModel.toJson(),
      'paymentStatus': paymentStatus,
      'orderStatus': orderStatus,
      'createdAt': createdAt,
    };
  }
}
