import 'package:t_store/features/shop/features/checkout/domain/repository/checkout_repository.dart';
import 'package:t_store/features/shop/features/order/data/models/order_model.dart';
import 'package:t_store/features/shop/features/order/data/source/order_firebase_service.dart';

class CheckoutRepositoryImpl extends CheckoutRepository {
  final OrderFirebaseService orderFirebaseService;
  CheckoutRepositoryImpl(this.orderFirebaseService);
  @override
  Future<void> placeOrder({required OrderModel order}) async {
    await orderFirebaseService.placeOrder(order: order);
  }
}
