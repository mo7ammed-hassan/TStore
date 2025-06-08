import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_state.dart';
import 'package:t_store/features/shop/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:t_store/service_locator.dart';
import 'package:t_store/utils/constants/sizes.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key, this.showAddRemoveButtons = true, this.physics});
  final bool showAddRemoveButtons;
  final ScrollPhysics? physics;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<CartCubit>(),
      child: BlocBuilder<CartCubit, CartState>(
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
      ),
    );
  }

  Widget _cartItemsList({required List<CartItemEntity> cartItems}) {
    return ListView.separated(
      itemCount: cartItems.length,
      shrinkWrap: true,
      physics: physics,
      itemBuilder: (context, index) => CartItemCard(
        showAddRemoveButtons: showAddRemoveButtons,
        cartItem: cartItems[index],
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: AppSizes.spaceBtwSections,
      ),
    );
  }

  Widget _loadingCartItems() {
    return Skeletonizer(
      child: Column(
        children: List.generate(
          3,
          (index) => CartItemCard(
            cartItem: CartItemEntity.empty(),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return const Center(
      child: Text('Something went wrong!, please try again later 🥲'),
    );
  }
}
