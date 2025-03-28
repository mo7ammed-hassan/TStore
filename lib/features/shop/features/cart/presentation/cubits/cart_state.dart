import 'package:equatable/equatable.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}


class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<CartItemEntity> cartItems;

  const CartLoadedState( this.cartItems);

  @override
  List<Object> get props => [cartItems];
}

class CartErrorState extends CartState {
  final String message;

  const CartErrorState(this.message);

  @override
  List<Object> get props => [message];
}
