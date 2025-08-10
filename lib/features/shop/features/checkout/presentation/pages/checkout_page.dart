import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/shop/features/cart/presentation/widgets/cart_items.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/checkout_button.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/chekout_order_detial.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/coupon_field.dart';
import 'package:t_store/utils/constants/sizes.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CheckoutButton(),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.spaceBtwItems),
          child: Column(
            children: [
              CartItems(showAddRemoveButtons: false),
              SizedBox(height: TSizes.spaceBtwSections),

              CouponFiled(),
              SizedBox(height: TSizes.spaceBtwSections),
              
              ChekoutOrderDetial(),
            ],
          ),
        ),
      ),
    );
  }
}
