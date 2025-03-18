import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_state.dart';
import 'package:t_store/features/shop/features/cart/presentation/widgets/cart_items.dart';
import 'package:t_store/features/shop/features/checkout/presentation/pages/checkout_page.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/service_locator.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/navigation.dart';
import 'package:t_store/utils/loaders/animation_loader.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cartCubit = getIt.get<CartCubit>();
    return BlocProvider.value(
      value: cartCubit,
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return Scaffold(
            appBar: _appBar(context),
            body: (cartCubit.totalCartItems == 0)
                ? _emptyWidget(context)
                : const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.spaceBtwItems - 2,
                      vertical: AppSizes.defaultSpace,
                    ),
                    child: CartItems(),
                  ),
            bottomNavigationBar: (cartCubit.totalCartItems == 0)
                ? null
                : _checkoutButton(context, cartCubit.totalCartPrice),
          );
        },
      ),
    );
  }

  TAnimationLoaderWidget _emptyWidget(BuildContext context) {
    return TAnimationLoaderWidget(
      text: 'Whoops! Cart is Empty.',
      animation: TImages.cartAnimation,
      showAction: true,
      actionText: 'Let\'s fill it',
      onActionPressed: () => context.removeAll(
        const NavigationMenu(),
      ),
    );
  }

  TAppBar _appBar(BuildContext context) {
    return TAppBar(
      showBackArrow: true,
      title: Text(
        'Cart',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  Widget _checkoutButton(BuildContext context, double totalPrice) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.defaultSpace,
        vertical: AppSizes.spaceBtwItems,
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CheckoutPage(),
            ),
          );
        },
        child: Text('Checkout \$${totalPrice.toStringAsFixed(2)}'),
      ),
    );
  }
}
