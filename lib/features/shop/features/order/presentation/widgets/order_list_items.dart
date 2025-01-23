import 'package:flutter/material.dart';
import 'package:t_store/features/shop/features/order/presentation/widgets/order_card.dart';
import 'package:t_store/utils/constants/sizes.dart';

class OrderListItems extends StatelessWidget {
  const OrderListItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => const OrderCard(),
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSizes.spaceBtwItems),
      itemCount: 6,
    );
  }
}
