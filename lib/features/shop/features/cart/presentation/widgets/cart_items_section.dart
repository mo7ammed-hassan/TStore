import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_cart_items_list.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_state.dart';
import 'package:t_store/features/shop/features/cart/presentation/widgets/cart_items_list.dart';

class CartItemsSection extends StatelessWidget {
  const CartItemsSection({
    super.key,
    this.showAddRemoveButtons = true,
    this.sliverList = false,
  });

  final bool showAddRemoveButtons;
  final bool sliverList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (_, state) {
        if (state is CartLoadingState) {
          return ShimmerCartItemsList(
            sliverList: sliverList,
          );
        }

        if (state is CartErrorState) {
          return _buildMessage('Something went wrong 🥲');
        }

        if (state is CartLoadedState) {
          if (state.cartItems.isEmpty) {
            return _buildMessage('Oops! your cart is empty 🥲');
          }

          return sliverList
              ? CartItemsList.sliver(state.cartItems, showAddRemoveButtons)
              : CartItemsList(
                  cartItems: state.cartItems,
                  showButtons: showAddRemoveButtons,
                );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildMessage(String message) {
    if (sliverList) {
      return SliverToBoxAdapter(
        child: Center(child: Text(message)),
      );
    }
    return Center(child: Text(message));
  }
}
