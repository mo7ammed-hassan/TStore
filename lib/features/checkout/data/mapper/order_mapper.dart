// OrderModel <-> OrderEntity Mapper Extension
import 'package:t_store/features/checkout/data/models/order_model.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';

extension OrderMapper on OrderModel {
  OrderEntity toEntity() {
    return OrderEntity(
      orderId: orderId ?? '',
      userId: userId ?? '',
      checkoutModel: checkoutModel,
      paymentStatus: paymentStatus,
      orderStatus: orderStatus,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension OrderEntityMapper on OrderEntity {
  OrderModel toModel() {
    return OrderModel(
      orderId: orderId,
      userId: userId,
      checkoutModel: checkoutModel,
      paymentStatus: paymentStatus,
      orderStatus: orderStatus,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
