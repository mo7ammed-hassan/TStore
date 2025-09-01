import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/common/widgets/brand/build_brands_section.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';

class AllBrandsPage extends StatelessWidget {
  const AllBrandsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: 'Brands',
      ),
      body: Padding(
        padding: context.responsiveInsets.symmetric(
          horizontal: TSizes.spaceBtwItems,
          vertical: TSizes.defaultSpace,
        ),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: TSectionHeading(
                title: 'Brands',
                showActionButton: false,
              ),
            ),
            SliverToBoxAdapter(
              child: ResponsiveGap.vertical(TSizes.spaceBtwItems),
            ),
            const BuildBrandsSection(),
          ],
        ),
      ),
    );
  }
}
