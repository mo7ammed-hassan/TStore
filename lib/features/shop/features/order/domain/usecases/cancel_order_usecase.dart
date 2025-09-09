import 'package:dartz/dartz.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/features/shop/features/order/domain/repositories/order_repository.dart';

class CancelOrderUsecase {
  final OrderRepository _orderRepository;
  CancelOrderUsecase(this._orderRepository);

  Future<Either<Failure, void>> call({required String orderId}) async {
    return await _orderRepository.cancelOrder(orderId: orderId);
  }
}
