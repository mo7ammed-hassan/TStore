import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_cart_item.dart';
import 'package:t_store/core/utils/constants/sizes.dart';

class ShimmerCartItemsList extends StatelessWidget {
  const ShimmerCartItemsList({
    super.key,
    this.itemCount = 3,
    this.sliverList = false,
  });
  final int itemCount;
  final bool sliverList;

  @override
  Widget build(BuildContext context) {
    if (sliverList) {
      return SliverList.separated(
        itemCount: itemCount,
        itemBuilder: (context, index) => const ShimmerCartItem(),
        separatorBuilder: (context, index) =>
            const SizedBox(height: TSizes.spaceBtwSections),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) => const ShimmerCartItem(),
      separatorBuilder: (context, index) =>
          const SizedBox(height: TSizes.spaceBtwSections),
    );
  }
}
