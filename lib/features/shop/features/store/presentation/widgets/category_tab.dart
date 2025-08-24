import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/models/get_all_products_param_model.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/all_products/domain/usecases/get_products_specific_category_use_case.dart';
import 'package:t_store/features/shop/features/all_products/presentation/pages/all_products_page.dart';
import 'package:t_store/features/shop/features/home/domain/entites/category_entity.dart';
import 'package:t_store/features/shop/features/store/presentation/cubits/store_cubit.dart';
import 'package:t_store/features/shop/features/store/presentation/widgets/brands_section.dart';
import 'package:t_store/features/shop/features/store/presentation/widgets/products_section.dart';
import 'package:t_store/config/service_locator.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/navigation.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';

class TCategoryTab extends StatelessWidget {
  final CategoryEntity category;
  const TCategoryTab({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    context
        .read<StoreCubit>()
        .fetchBrandsSpecificCategory(categoryId: category.id);

    return Padding(
      padding: context.responsiveInsets.symmetric(
        vertical: TSizes.md,
        horizontal: TSizes.spaceBtwItems,
      ),
      child: CustomScrollView(
        slivers: [
          const BrandsSection(),
          SliverToBoxAdapter(
            child: ResponsiveGap.vertical(TSizes.spaceBtwItems + 2),
          ),
          SliverToBoxAdapter(
            child: TSectionHeading(
              title: 'You might like',
              showActionButton: true,
              onPressed: () => _viewAllProducts(context),
            ),
          ),
          SliverToBoxAdapter(
            child: ResponsiveGap.vertical(TSizes.spaceBtwItems),
          ),
          ProductsSection(categoryId: category.id),
          SliverToBoxAdapter(
            child: ResponsiveGap.vertical(TSizes.spaceBtwSections),
          ),
        ],
      ),
    );
  }

  void _viewAllProducts(BuildContext context) {
    context.pushPage(
      AllProductsPage(
        future: getIt.get<GetProductsSpecificCategoryUseCase>().call(
              params: GetAllParams(id: category.id, limit: 10),
            ),
        title: 'All Products',
      ),
    );
  }
}
