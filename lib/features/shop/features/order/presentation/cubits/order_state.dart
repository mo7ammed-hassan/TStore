import 'package:equatable/equatable.dart';
import 'package:t_store/features/shop/features/order/data/models/order_model.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderFailureState extends OrderState {
  final String message;

  OrderFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class OrderSuccessState extends OrderState {
  final List<OrderModel> _orders;

  OrderSuccessState(List<OrderModel> orders) : _orders = List.unmodifiable(orders);

  List<OrderModel> get orders => _orders; 

  @override
  List<Object?> get props => [_orders]; 
}
