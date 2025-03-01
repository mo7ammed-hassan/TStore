import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/features/personalization/pages/address/data/models/address_model.dart';
import 'package:t_store/features/shop/features/cart/data/models/cart_item_model.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel addressModel;
  final DateTime deliveryDate;
  final List<CartItemModel> cartItems;

  OrderModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    this.paymentMethod = 'PayPal',
    required this.addressModel,
    required this.deliveryDate,
    required this.cartItems,
  });

  String get formattedOrderDate => HelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate =>
      HelperFunctions.getFormattedDate(deliveryDate);

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
          ? 'Shipped'
          : 'Processing';

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['id'],
        userId: json['userId'],
        status: OrderStatus.values
            .firstWhere((e) => e.toString() == json['status']),
        totalAmount: json['totalAmount'],
        orderDate: json['orderDate'] is Timestamp
          ? (json['orderDate'] as Timestamp).toDate()
          : DateTime.tryParse(json['orderData']) ?? DateTime.now(),
        paymentMethod: json['paymentMethod'],
        addressModel: AddressModel.fromJson(json['address']),
        deliveryDate: json['deliveryDate'] is Timestamp
          ? (json['deliveryDate'] as Timestamp).toDate()
          : DateTime.tryParse(json['deliveryDate']) ?? DateTime.now(),
        cartItems: List<CartItemModel>.from(
          json['cartItems'].map((item) => CartItemModel.fromJson(item)),
        ),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'status': status.toString(),
        'totalAmount': totalAmount,
        'orderDate': orderDate,
        'paymentMethod': paymentMethod,
        'address': addressModel.toJson(),
        'deliveryDate': deliveryDate,
        'cartItems': List<dynamic>.from(cartItems.map((item) => item.toJson())),
      };
}
