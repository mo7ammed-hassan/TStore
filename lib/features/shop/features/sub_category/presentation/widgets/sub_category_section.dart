import 'package:flutter/material.dart';
import 'package:t_store/common/models/get_all_products_param_model.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/all_products/domain/usecases/get_products_specific_category_use_case.dart';
import 'package:t_store/features/shop/features/all_products/presentation/pages/all_products_page.dart';
import 'package:t_store/features/shop/features/home/domain/entites/category_entity.dart';
import 'package:t_store/features/shop/features/sub_category/presentation/widgets/build_sub_category_products.dart';
import 'package:t_store/service_locator.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/navigation.dart';

class SubCategorySection extends StatelessWidget {
  const SubCategorySection({
    super.key,
    required this.subCategory,
  });
  final CategoryEntity subCategory;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spaceBtwSections),
      child: Column(
        children: [
          TSectionHeading(
            title: subCategory.name,
            onPressed: () {
              context.pushPage(
                AllProductsPage(
                  future: getIt.get<GetProductsSpecificCategoryUseCase>().call(
                        params: GetAllParams(id: subCategory.id, limit: 10),
                      ),
                  title: subCategory.name,
                ),
              );
            },
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          SizedBox(
            height: 120,
            child: BuildSubCategoryProducts(subCategoryId: subCategory.id),
          ),
        ],
      ),
    );
  }
}
