import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/success_pages/success_page.dart';
import 'package:t_store/features/shop/features/cart/presentation/widgets/cart_items.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/chekout_order_detial.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/coupon_field.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _checkoutButton(context),
      appBar: _appBar(context),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.spaceBtwItems),
          child: Column(
            children: [
              CartItems(
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
    );
  }

  Widget _checkoutButton(BuildContext context) {
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
              builder: (context) => SuccessPage(
                title: 'Payment Success!',
                subtitle: 'Your items will be shipping soon!',
                image: TImages.successfulPaymentIcon,
                onPressed: () {
                  // Navigate to success page after payment success
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NavigationMenu(),
                    ),
                  );
                },
              ),
            ),
          );
        },
        child: const Text('Checkout \$300'),
      ),
    );
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
