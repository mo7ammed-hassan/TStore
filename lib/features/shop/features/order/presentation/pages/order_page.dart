import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/shop/features/order/presentation/widgets/order_list_items.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: 'My Orders',
      ),
      body: Padding(
        padding: context.responsiveInsets.symmetric(
          horizontal: TSizes.spaceBtwItems,
          vertical: TSizes.defaultSpace / 2,
        ),
        child: const OrderListItems(),
      ),
    );
  }
}
