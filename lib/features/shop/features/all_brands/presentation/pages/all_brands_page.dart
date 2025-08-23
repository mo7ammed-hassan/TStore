import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/common/widgets/brand/build_brands_section.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class AllBrandsPage extends StatelessWidget {
  const AllBrandsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: TSizes.spaceBtwItems,
          vertical: TSizes.defaultSpace,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: TSectionHeading(
                title: 'Brands',
                showActionButton: false,
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: TSizes.spaceBtwItems)),
            BuildBrandsSection(),
          ],
        ),
      ),
    );
  }

  TAppBar _appBar(BuildContext context) {
    return TAppBar(
      showBackArrow: true,
      title: ResponsiveText(
        'Brands',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
