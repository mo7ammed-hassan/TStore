import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_brand_card.dart';
import 'package:t_store/core/utils/constants/sizes.dart' show TSizes;

class ShimmerBramdsList extends StatelessWidget {
  const ShimmerBramdsList({super.key, this.itemCount = 4});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 80,
        mainAxisSpacing: TSizes.defaultSpace / 2,
        crossAxisSpacing: TSizes.defaultSpace / 2,
      ),
      itemBuilder: (context, index) => const ShimmerBrandCard(),
    );
  }
}
