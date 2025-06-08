import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/home/presentation/cubits/category/category_cubit.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/categories/home_categories.dart';
import 'package:t_store/utils/constants/sizes.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit()..getAllCategories(),
      child: const Padding(
        padding: EdgeInsets.only(left: AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TSectionHeading(
              title: 'Popular Categories',
              showActionButton: false,
              textColor: Colors.white,
            ),
            SizedBox(height: AppSizes.spaceBtwItems),
            THomeCategories(),
            SizedBox(height: AppSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
