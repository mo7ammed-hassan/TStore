import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_horizantal_product_card.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ShimmerSubCategoryProducts extends StatelessWidget {
  const ShimmerSubCategoryProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => SizedBox(
          width: 310,
          child: const ShimmerHorizantalProductCard(),
        ),
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: TSizes.spaceBtwItems),
      ),
    );
  }
}
