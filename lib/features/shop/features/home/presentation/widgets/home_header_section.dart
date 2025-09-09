import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/primary_header_conatiner.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/categories/categories_sections.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/home_app_bar.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return TPrimaryHeaderConatiner(
      child: Column(
        children: [
          const THomeAppBar(),
          ResponsiveGap.vertical(TSizes.spaceBtwSections / 2),
          const TSearchConatiner(text: 'Search in Store'),
          ResponsiveGap.vertical(TSizes.spaceBtwSections / 2),
          const CategoriesSection(),
        ],
      ),
    );
  }
}
