import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_cart_item.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_state.dart';
import 'package:t_store/features/shop/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:t_store/utils/constants/sizes.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key, this.showAddRemoveButtons = true});
  final bool showAddRemoveButtons;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoadingState) {
          return _loadingCartItems();
        }

        if (state is CartLoadedState) {
          if (state.cartItems.isEmpty) {
            return const Center(
              child: Text('Oops! your cart is empty 🥲'),
            );
          }
          return _cartItemsList(cartItems: state.cartItems);
        }

        if (state is CartErrorState) {
          return _buildErrorWidget();
        }

        return const Center(
          child: Text('Something went wrong!, please try again later 🥲'),
        );
      },
    );
  }

  Widget _cartItemsList({required List<CartItemEntity> cartItems}) {
    return ListView.separated(
      itemCount: cartItems.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => CartItemCard(
        showAddRemoveButtons: showAddRemoveButtons,
        cartItem: cartItems[index],
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: TSizes.spaceBtwSections,
      ),
    );
  }

  Widget _loadingCartItems() {
    return ShimmerCartItem();
  }

  Widget _buildErrorWidget() {
    return const Center(
      child: Text('Something went wrong!, please try again later 🥲'),
    );
  }
}
