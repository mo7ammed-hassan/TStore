import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/t_appbar.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_state.dart';
import 'package:t_store/features/shop/features/cart/presentation/widgets/cart_checkout_button.dart';
import 'package:t_store/features/shop/features/cart/presentation/widgets/cart_items_section.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_padding.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context) {
    final state = context.select<CartCubit, CartLoadedState?>((cubit) {
      final state = cubit.state;
      if (state is CartLoadedState) {
        return state;
      }
      return null;
    });

    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: 'Cart',
      ),
      body: ResponsivePadding.symmetric(
        horizontal: TSizes.spaceBtwItems,
        vertical: TSizes.defaultSpace,
        child: const CartItemsSection(),
      ),
      bottomNavigationBar: state != null && state.cartItems.isNotEmpty
          ? CartCheckoutButton(
              items: state.cartItems,
              total: state.totalPrice,
            )
          : null,
    );
  }
}
