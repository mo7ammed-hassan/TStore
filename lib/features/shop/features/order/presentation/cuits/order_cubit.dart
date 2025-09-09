import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/shop/features/order/domain/usecases/order_usecases.dart';
import 'package:t_store/features/shop/features/order/presentation/cuits/order_states.dart';
import 'package:t_store/core/utils/constants/enums.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit(this._orderUsecases) : super(OrderStates());

  final OrderUsecases _orderUsecases;

  Future<void> fetchOrders() async {
    emit(state.copyWith(status: OrderStateStatus.loading));

    final result = await _orderUsecases.fetchOrdersUsecase.call();
    result.fold(
      (error) => emit(state.copyWith(
          status: OrderStateStatus.failure, errorMessage: error.message)),
      (orders) {
        emit(state.copyWith(status: OrderStateStatus.success, orders: orders));
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
        status: OrderStateStatus.success,
        orders: updatedOrders,
      ),
    );

    final result =
        await _orderUsecases.cancelOrderUsecase.call(orderId: orderId);
    result.fold(
      (error) {
        emit(
          currentState.copyWith(
            status: OrderStateStatus.failure,
            errorMessage: error.message,
            orders: oldOrders, // rollback
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
              status: OrderStateStatus.success, orders: updatedOrders),
        );
      },
    );
  }

  void changeOrderStaus(final String orderId) {
    final index =
        state.orders?.indexWhere((element) => element.orderId == orderId);
    if (index == null || index == -1) return;

    final order = state.orders?[index];
    final newOrder = order?.copyWith(orderStatus: OrderStatus.processing.name);

    final updatedOrders = List.of(state.orders!);
    updatedOrders[index] = newOrder!;

    emit(state.copyWith(orders: updatedOrders));
  }
}
