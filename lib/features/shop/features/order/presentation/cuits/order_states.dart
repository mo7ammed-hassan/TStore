import 'package:t_store/features/checkout/domain/entities/order_entity.dart';

enum OrderStateStatus { initial, loading, success, failure }

class OrderStates {
  final OrderStateStatus status;
  final List<OrderEntity>? orders;
  final String? errorMessage;

  OrderStates({
    this.status = OrderStateStatus.initial,
    this.orders,
    this.errorMessage,
  });

  OrderStates copyWith({
    OrderStateStatus? status,
    List<OrderEntity>? orders,
    String? errorMessage,
  }) {
    return OrderStates(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
