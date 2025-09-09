import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/all_products/presentation/pages/all_products_page.dart';
import 'package:t_store/features/shop/features/home/domain/entites/category_entity.dart';
import 'package:t_store/features/shop/features/sub_category/presentation/widgets/build_sub_category_products.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/navigation.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';

class SubCategorySection extends StatelessWidget {
  const SubCategorySection({
    super.key,
    required this.subCategory,
  });
  final CategoryEntity subCategory;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.responsiveInsets.only(bottom: TSizes.spaceBtwSections),
      child: Column(
        children: [
          TSectionHeading(
            title: subCategory.name,
            onPressed: () {
              context.pushPage(
                AllProductsPage(
                  categoryId: subCategory.id,
                  title: subCategory.name,
                ),
              );
            },
          ),
          ResponsiveGap.vertical(TSizes.spaceBtwItems / 2),
          SizedBox(
            height: 120,
            child: BuildSubCategoryProducts(subCategoryId: subCategory.id),
          ),
        ],
      ),
    );
  }
}
