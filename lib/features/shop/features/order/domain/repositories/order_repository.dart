import 'package:dartz/dartz.dart';
import 'package:t_store/features/shop/features/order/data/models/order_model.dart';

abstract class OrderRepository{
  Future<Either<String, void>> placeOrder({required OrderModel order});
  Future<Either<String, List<OrderModel>>> getAllOrders();
}