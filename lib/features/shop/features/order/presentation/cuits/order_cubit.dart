import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/shop/features/order/domain/usecases/order_usecases.dart';
import 'package:t_store/features/shop/features/order/presentation/cuits/order_states.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit(this._orderUsecases) : super(OrderStates());

  final OrderUsecases _orderUsecases;

  Future<void> fetchOrders() async {
    emit(state.copyWith(status: OrderStatus.loading));

    final result = await _orderUsecases.fetchOrdersUsecase.call();
    result.fold(
      (error) => emit(state.copyWith(
          status: OrderStatus.failure, errorMessage: error.message)),
      (orders) {
        emit(state.copyWith(status: OrderStatus.success, orders: orders));
      },
    );
  }

  Future<void> cancelOrder(String orderId) async {
    final currentState = state;
    final List<OrderEntity> oldOrders = List.from(state.orders ?? []);

    final List<OrderEntity> updatedOrders = List.from(oldOrders)
      ..removeWhere((element) => element.orderId == orderId);

    emit(
      state.copyWith(
        status: OrderStatus.success,
        orders: updatedOrders,
      ),
    );

    final result =
        await _orderUsecases.cancelOrderUsecase.call(orderId: orderId);
    result.fold(
      (error) {
        emit(
          currentState.copyWith(
            status: OrderStatus.failure,
            errorMessage: error.message,
            orders: oldOrders, // rollback
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(status: OrderStatus.success, orders: updatedOrders),
        );
      },
    );
  }
}
