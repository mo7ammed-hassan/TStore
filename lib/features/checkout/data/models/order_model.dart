import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/features/checkout/data/models/checkout_model.dart';
import 'package:t_store/features/personalization/pages/address/data/models/address_model.dart';

class OrderModel {
  final String?
      orderId; // created draft id from server (nullable until draft created)
  final String? userId;
  final AddressModel? shippingAddress;
  final CheckoutModel checkoutModel;
  final String paymentStatus;
  final String orderStatus;
  final Timestamp createdAt;
  final Timestamp? updatedAt;

  OrderModel({
    this.orderId,
    this.userId,
    this.shippingAddress,
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
      shippingAddress: AddressModel.fromJson(
          json['shippingAddress'] as Map<String, dynamic>),
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
      'shippingAddress': shippingAddress?.toJson(),
      'checkoutModel': checkoutModel.toJson(),
      'paymentStatus': paymentStatus,
      'orderStatus': orderStatus,
      'createdAt': createdAt,
    };
  }
}
