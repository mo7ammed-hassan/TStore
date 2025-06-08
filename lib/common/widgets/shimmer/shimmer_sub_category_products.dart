import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:t_store/common/widgets/products/product_cards/horizantal_product_card.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
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
        itemBuilder: (context, index) => const Skeletonizer(
          child: HorizantalProductCard(
            product: ProductEntity.empty(),
          ),
        ),
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: AppSizes.spaceBtwItems),
      ),
    );
  }
}
