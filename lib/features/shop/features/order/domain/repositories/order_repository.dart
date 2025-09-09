import 'package:dartz/dartz.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderEntity>>> fetchAllOrders();
  Future<Either<Failure, void>> cancelOrder({required String orderId});
  Future<Either<Failure, OrderEntity>> updateOrderStatus(
      {required OrderEntity order});
}
