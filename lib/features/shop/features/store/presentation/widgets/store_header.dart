import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/home/presentation/cubits/category/category_cubit.dart';
import 'package:t_store/features/shop/features/store/presentation/widgets/build_brands_section.dart';
import 'package:t_store/common/widgets/appbar/tabbar.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

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
      expandedHeight: 420,
      flexibleSpace: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(height: TSizes.spaceBtwItems),
            ),
            const SliverToBoxAdapter(
              child: TSearchConatiner(
                text: 'Search in Store',
                padding: EdgeInsets.zero,
                showBackground: false,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: TSizes.spaceBtwItems),
            ),
            SliverToBoxAdapter(
              child: TSectionHeading(
                title: 'Future Brands',
                onPressed: onViewAllBrands,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: TSizes.spaceBtwItems / 2),
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
