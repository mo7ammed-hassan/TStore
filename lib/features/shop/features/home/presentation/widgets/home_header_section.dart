import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/primary_header_conatiner.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/categories/categories_sections.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/home_app_bar.dart';
import 'package:t_store/utils/constants/sizes.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const TPrimaryHeaderConatiner(
      child: Column(
        children: [
          THomeAppBar(),
          SizedBox(height: AppSizes.spaceBtwSections / 2),
          TSearchConatiner(text: 'Search in Store'),
          SizedBox(height: AppSizes.spaceBtwSections / 2),
          CategoriesSection(),
        ],
      ),
    );
  }
}
