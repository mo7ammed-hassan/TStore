import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/errors/failures.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/shop/features/order/domain/repositories/order_repository.dart';

class FetchOrdersUsecase {
  final OrderRepository _checkoutRepository;

  FetchOrdersUsecase(this._checkoutRepository);

  Future<Either<Failure, List<OrderEntity>>> call() async {
    return await _checkoutRepository.fetchAllOrders();
  }
}
