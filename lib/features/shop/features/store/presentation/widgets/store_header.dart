import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/home/presentation/cubits/category/category_cubit.dart';
import 'package:t_store/common/widgets/brand/build_brands_section.dart';
import 'package:t_store/common/widgets/appbar/tabbar.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';

class StoreHeader extends StatelessWidget {
  final VoidCallback onViewAllBrands;
  const StoreHeader({super.key, required this.onViewAllBrands});

  @override
  Widget build(BuildContext context) {
    final categories = context.read<CategoryCubit>().featuredCategories;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      floating: true,
      backgroundColor: HelperFunctions.isDarkMode(context)
          ? AppColors.black
          : AppColors.white,
      expandedHeight: context.vertSize(400),
      flexibleSpace: Padding(
        padding: context.responsiveInsets.all(TSizes.defaultSpace),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: TSearchConatiner(
                text: 'Search in Store',
                padding: EdgeInsets.zero,
                showBackground: false,
              ),
            ),
            SliverToBoxAdapter(
              child: ResponsiveGap.vertical(TSizes.spaceBtwItems),
            ),
            SliverToBoxAdapter(
              child: TSectionHeading(
                title: 'Future Brands',
                onPressed: onViewAllBrands,
              ),
            ),
            SliverToBoxAdapter(
              child: ResponsiveGap.vertical(TSizes.spaceBtwItems / 2),
            ),
            const BuildBrandsSection(feturerand: true),
          ],
        ),
      ),
      bottom: TTabBar(
        tabs: categories
            .map(
              (category) => Tab(child: Text(category.name)),
            )
            .toList(),
      ),
    );
  }
}
