import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_cart_item.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_state.dart';
import 'package:t_store/features/shop/features/cart/presentation/widgets/cart_items_list.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key, this.showAddRemoveButtons = true});
  final bool showAddRemoveButtons;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoadingState) {
          return const ShimmerCartItem();
        }

        if (state is CartLoadedState) {
          if (state.cartItems.isEmpty) {
            return const Center(
              child: Text('Oops! your cart is empty 🥲'),
            );
          }

          return CartItemsList(
            cartItems: state.cartItems,
            showAddRemoveButtons: showAddRemoveButtons,
          );
        }

        if (state is CartErrorState) {
          return const Center(
            child: Text('Something went wrong!, please try again later 🥲'),
          );
        }

        return const Center(
          child: Text('Something went wrong!, please try again later 🥲'),
        );
      },
    );
  }
}
