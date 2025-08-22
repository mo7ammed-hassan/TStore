import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_state.dart';
import 'package:t_store/features/shop/features/cart/presentation/widgets/cart_items_section.dart';
import 'package:t_store/features/shop/features/checkout/presentation/pages/order_review_screen.dart';
import 'package:t_store/utils/constants/sizes.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final hasItems = state is CartLoadedState && state.cartItems.isNotEmpty;

        return Scaffold(
          appBar: _buildAppBar(context),
          bottomNavigationBar: hasItems ? _buildCheckoutButton(context) : null,
          body: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: TSizes.spaceBtwItems,
              vertical: TSizes.defaultSpace,
            ),
            child: CartItemsSection(),
          ),
        );
      },
    );
  }

  TAppBar _buildAppBar(BuildContext context) {
    return TAppBar(
      showBackArrow: true,
      title: Text(
        'Cart',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    final totalPrice = context.read<CartCubit>().totalPrice;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.defaultSpace,
        vertical: TSizes.spaceBtwItems,
      ),
      child: ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const OrderReviewScreen()),
        ),
        child: Text('Checkout \$${totalPrice.toStringAsFixed(2)}'),
      ),
    );
  }
}
