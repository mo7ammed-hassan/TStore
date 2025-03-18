import 'package:t_store/features/shop/features/order/data/models/order_model.dart';

abstract class CheckoutRepository {
  Future<void> placeOrder({required OrderModel order});
}