import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/brands/brand_card.dart';
import 'package:t_store/features/shop/features/all_brands/domain/entities/brand_entity.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';

class BrandsGridView extends StatelessWidget {
  const BrandsGridView({super.key, required this.brands});
  final List<BrandEntity> brands;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: brands.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: context.horzSize(72),
        mainAxisSpacing: context.horzSize(TSizes.defaultSpace / 2),
        crossAxisSpacing: context.horzSize(TSizes.defaultSpace / 2),
      ),
      itemBuilder: (context, index) {
        final brand = brands[index];

        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.5, end: 1),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 80 * (1 - value)),
              child: child,
            );
          },
          child: TBrandCard(key: ValueKey(brand.id), brand: brand),
        );
      },
    );
  }
}
