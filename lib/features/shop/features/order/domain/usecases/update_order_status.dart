import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/errors/failures.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/shop/features/order/domain/repositories/order_repository.dart';

class UpdateOrderStatusUsecase {
  final OrderRepository _orderRepository;
  UpdateOrderStatusUsecase(this._orderRepository);

  Future<Either<Failure, void>> call({required OrderEntity order}) async {
    return await _orderRepository.updateOrderStatus(order: order);
  }
}
