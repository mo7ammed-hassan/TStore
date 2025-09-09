import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_vertical_product_card.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';

class ShimmerProductsGridLayout extends StatelessWidget {
  final int itemCount;
  const ShimmerProductsGridLayout({super.key, this.itemCount = 4});

  static Widget sliver(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return const ShimmerVerticalProductCard();
        },
        childCount: 4,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: context.horzSize(50) / context.vertSize(86),
        mainAxisSpacing: context.vertSize(TSizes.gridViewSpacing),
        crossAxisSpacing: context.horzSize(TSizes.gridViewSpacing),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: context.horzSize(50) / context.vertSize(86),
        mainAxisSpacing: context.vertSize(TSizes.gridViewSpacing),
        crossAxisSpacing: context.horzSize(TSizes.gridViewSpacing),
      ),
      itemBuilder: (context, index) {
        return const ShimmerVerticalProductCard();
      },
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
