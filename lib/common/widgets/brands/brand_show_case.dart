import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/brands/brand_card.dart';
import 'package:t_store/common/widgets/brands/brand_products_section.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/features/shop/features/all_brands/domain/entities/brand_entity.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TBrandShowcase extends StatelessWidget {
  final BrandEntity brand;
  const TBrandShowcase({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      showBorder: true,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(TSizes.md),
      child: Column(
        children: [
          // Brand with Product Conunt
          TBrandCard(brand: brand, showBorder: false),
          const SizedBox(height: TSizes.spaceBtwItems),
          //Brand Top 3 Product Image
          BrandProductsSection(brandId: brand.id),
        ],
      ),
    );
  }
}
