import 'package:t_store/features/checkout/domain/entities/checkout_entity.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/utils/constants/enums.dart';

abstract class CheckoutRepository {
  Future<OrderEntity> createOrderDraft({
    required CheckoutEntity checkoutData,
  });

  Future<CheckoutEntity> syncCartWithServer(
      {required List<CartItemEntity> itemsPayload});

  Future<void> updateOrderPaymentStatus({
    required String orderId,
    required PaymentStatus newStatus,
  });
}
