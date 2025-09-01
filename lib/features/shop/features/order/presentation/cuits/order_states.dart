import 'package:t_store/features/checkout/domain/entities/order_entity.dart';

enum OrderStatus { initial, loading, success, failure }

class OrderStates {
  final OrderStatus status;
  final List<OrderEntity>? orders;
  final String? errorMessage;

  OrderStates({
    this.status = OrderStatus.initial,
    this.orders,
    this.errorMessage,
  });

  OrderStates copyWith({
    OrderStatus? status,
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
