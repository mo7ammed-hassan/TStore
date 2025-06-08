import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/success_pages/success_page.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/features/shop/features/cart/presentation/widgets/cart_items.dart';
import 'package:t_store/features/shop/features/checkout/presentation/cubits/checkout_cubit.dart';
import 'package:t_store/features/shop/features/checkout/presentation/cubits/checkout_state.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/chekout_order_detial.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/coupon_field.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/service_locator.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/navigation.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loaders.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutCubit()..initPaymentMethod(),
      child: Scaffold(
        bottomNavigationBar: _checkoutButton(context),
        appBar: _appBar(context),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.spaceBtwItems),
            child: Column(
              children: [
                CartItems(
                  physics: NeverScrollableScrollPhysics(),
                  showAddRemoveButtons: false,
                ),
                SizedBox(height: AppSizes.spaceBtwSections),
                CouponFiled(),
                SizedBox(height: AppSizes.spaceBtwSections),
                ChekoutOrderDetial(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _checkoutButton(BuildContext context) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.defaultSpace,
          vertical: AppSizes.spaceBtwItems,
        ),
        child: BlocListener<CheckoutCubit, CheckoutState>(
          listenWhen: (previous, current) =>
              current is CheckoutLoadingState ||
              current is CheckoutErrorState ||
              current is CheckoutSuccessState,
          listener: (context, state) {
            if (state is CheckoutLoadingState) {
              TFullScreenLoader.openLoadingDialog(
                'Processing your order...',
                TImages.pencilAnimation,
              );
            }
            if (state is CheckoutErrorState) {
              TFullScreenLoader.stopLoading();
              Loaders.warningSnackBar(
                  title: 'Error', message: state.errorMessage);
            }

            if (state is CheckoutSuccessState) {
              TFullScreenLoader.stopLoading();
              context.pushPage(
                SuccessPage(
                  title: 'Payment Success!',
                  subtitle: 'Your items will be shipping soon!',
                  image: TImages.completeOrder,
                  onPressed: () async {
                    context.pushPage(const NavigationMenu());
                  },
                ),
              );
            }
          },
          child: ElevatedButton(
            onPressed: () async {
              final checkoutCubit = context.read<CheckoutCubit>();
              checkoutCubit.cartItems = getIt.get<CartCubit>().cartItemsList;
              checkoutCubit.calculateSubTotalAmount() > 0
                  ? await checkoutCubit.checkout()
                  : null;
            },
            child: Text(
              'Checkout \$${context.read<CheckoutCubit>().calculateTotalAmount().toStringAsFixed(2)}',
            ),
          ),
        ),
      );
    });
  }

  TAppBar _appBar(BuildContext context) {
    return TAppBar(
      showBackArrow: true,
      title: Text(
        'Order Review',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
