import 'package:dartz/dartz.dart';
import 'package:t_store/features/shop/features/order/data/models/order_model.dart';
import 'package:t_store/features/shop/features/order/data/source/order_firebase_service.dart';
import 'package:t_store/features/shop/features/order/domain/repositories/order_repository.dart';

class OrderRepositoryImpl extends OrderRepository {
  final OrderFirebaseService orderFirebaseService;
  OrderRepositoryImpl(this.orderFirebaseService);
  @override
  Future<Either<String, List<OrderModel>>> getAllOrders() async {
    var returendOrders = await orderFirebaseService.getAllOrders();
    return returendOrders.fold(
      (error) => Left(error),
      (data) {
        List<OrderModel> orders = List.from(data)
            .map((document) => OrderModel.fromJson(document))
            .toList();
        return Right(orders);
      },
    );
  }

  @override
  Future<Either<String, void>> placeOrder({required OrderModel order}) async {
    return await orderFirebaseService.placeOrder(order: order);
  }
}
