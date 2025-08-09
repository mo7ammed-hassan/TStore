import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_vertical_product_card.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ShimmerProductsGridLayout extends StatelessWidget {
  final int itemCount;
  const ShimmerProductsGridLayout({super.key, this.itemCount = 4});

  static Widget sliver() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return const ShimmerVerticalProductCard();
        },
        childCount: 4,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        mainAxisSpacing: TSizes.gridViewSpacing,
        crossAxisSpacing: TSizes.gridViewSpacing,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        mainAxisSpacing: TSizes.gridViewSpacing,
        crossAxisSpacing: TSizes.gridViewSpacing,
      ),
      itemBuilder: (context, index) {
        return ShimmerVerticalProductCard();
      },
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
