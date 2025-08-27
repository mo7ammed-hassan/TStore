import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/shop/features/cart/presentation/widgets/cart_items_section.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/checkout_button.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/chekout_order_detial.dart';
import 'package:t_store/features/shop/features/checkout/presentation/widgets/coupon_field.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart'
    show ResponsiveGap;
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class OrderReviewScreen extends StatelessWidget {
  const OrderReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CheckoutButton(),
      appBar: TAppBar(
        showBackArrow: true,
        title: ResponsiveText(
          'Order Review',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: context.responsiveInsets.all(TSizes.spaceBtwItems),
        child: CustomScrollView(
          slivers: [
            CartItemsSection(showAddRemoveButtons: false, sliverList: true),
            SliverToBoxAdapter(
              child: ResponsiveGap.vertical(TSizes.spaceBtwSections),
            ),
            SliverToBoxAdapter(child: const CouponFiled()),
            SliverToBoxAdapter(
              child: ResponsiveGap.vertical(TSizes.spaceBtwSections),
            ),
            SliverToBoxAdapter(
              child: const ChekoutOrderDetial(),
            ),
          ],
        ),
      ),
    );
  }
}
