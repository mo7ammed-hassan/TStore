import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/errors/failures.dart';
import 'package:t_store/features/shop/features/order/domain/repositories/order_repository.dart';
import 'package:t_store/utils/constants/enums.dart';

class UpdateOrderStatusUsecase {
  final OrderRepository _orderRepository;
  UpdateOrderStatusUsecase(this._orderRepository);

  Future<Either<Failure, void>> call({
    required String orderId,
    required OrderStatus orderStatus,
    PaymentStatus? paymentStatus,
  }) async {
    return await _orderRepository.updateOrderStatus(
      orderId: orderId,
      paymentStatus: paymentStatus,
      orderStatus: orderStatus,
    );
  }
}
