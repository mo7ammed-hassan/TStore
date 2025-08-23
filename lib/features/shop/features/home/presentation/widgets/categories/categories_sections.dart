import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/home/presentation/cubits/category/category_cubit.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/categories/home_categories.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit()..getAllCategories(),
      child: Padding(
        padding: context.responsiveInsets.only(left: TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(
              title: 'Popular Categories',
              showActionButton: false,
              textColor: Colors.white,
            ),
            ResponsiveGap.vertical(TSizes.spaceBtwItems),
            const THomeCategories(),
            ResponsiveGap.vertical(TSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
