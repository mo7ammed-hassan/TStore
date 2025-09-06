// OrderModel <-> OrderEntity Mapper Extension
import 'package:t_store/features/checkout/data/mapper/checout_mapper.dart';
import 'package:t_store/features/checkout/data/models/order_model.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/personalization/pages/address/data/mapper/address_mapper.dart';

extension OrderMapper on OrderModel {
  OrderEntity toEntity() {
    return OrderEntity(
      orderId: orderId ?? '',
      userId: userId ?? '',
      checkoutModel: checkoutModel.toEntity(),
      paymentStatus: paymentStatus ?? '',
      paymentIntentId: paymentIntentId ?? '',
      transactionId: transactionId ?? '',
      orderStatus: orderStatus ?? '',
      shippingAddress: shippingAddress?.toEntity(),
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
      checkoutModel: checkoutModel.toModel(),
      shippingAddress: shippingAddress?.toModel(),
      paymentIntentId: paymentIntentId,
      transactionId: transactionId,
      paymentStatus: paymentStatus,
      orderStatus: orderStatus,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
