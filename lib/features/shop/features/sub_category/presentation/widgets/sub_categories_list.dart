import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/products/product_cards/product_card_horizantal.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/utils/constants/sizes.dart';

class SubCategoriesList extends StatelessWidget {
  const SubCategoriesList({super.key, required this.products});
  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: products.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) =>
          ProductCardHorizantal(product: products[index]),
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(width: TSizes.spaceBtwItems),
    );
  }
}
