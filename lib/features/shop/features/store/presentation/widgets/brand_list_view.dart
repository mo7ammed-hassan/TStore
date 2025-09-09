import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/animation_containers/open_container_wrapper.dart';
import 'package:t_store/common/widgets/brands/brand_show_case.dart';
import 'package:t_store/features/shop/features/all_brands/domain/entities/brand_entity.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/pages/brand_products_page.dart';
import 'package:t_store/core/utils/constants/sizes.dart' show TSizes;
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';

class BrandListView extends StatelessWidget {
  const BrandListView({super.key, required this.brands});
  final List<BrandEntity> brands;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemBuilder: (context, index) => OpenContainerWrapper(
        nextScreen: BrandProductsPage(brand: brands[index]),
        radius: const Radius.circular(TSizes.cardRadiusLg),
        child: TBrandShowcase(brand: brands[index]),
      ),
      separatorBuilder: (context, index) => ResponsiveGap.vertical(TSizes.md),
      itemCount: brands.length,
    );
  }
}
