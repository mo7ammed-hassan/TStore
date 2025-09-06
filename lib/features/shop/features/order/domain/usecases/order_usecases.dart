import 'package:t_store/features/shop/features/order/domain/usecases/cancel_order_usecase.dart';
import 'package:t_store/features/shop/features/order/domain/usecases/fetch_orders_usecase.dart';
import 'package:t_store/features/shop/features/order/domain/usecases/update_order_status.dart';

class OrderUsecases {
  final FetchOrdersUsecase fetchOrdersUsecase;
  final CancelOrderUsecase cancelOrderUsecase;
  final UpdateOrderStatusUsecase updateOrderStatusUsecase;

  OrderUsecases({
    required this.fetchOrdersUsecase,
    required this.cancelOrderUsecase,
    required this.updateOrderStatusUsecase,
  });
}
