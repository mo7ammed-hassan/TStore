import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/widgets/build_brands_list.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AllBrandsPage extends StatelessWidget {
  const AllBrandsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.spaceBtwItems,
          vertical: AppSizes.defaultSpace,
        ),
        child: Column(
          children: [
            TSectionHeading(
              title: 'Brands',
              showActionButton: false,
            ),
            SizedBox(height: AppSizes.spaceBtwItems),
            Expanded(child: BuildBrandsList()),
          ],
        ),
      ),
    );
  }

  TAppBar _appBar(BuildContext context) {
    return TAppBar(
      showBackArrow: true,
      title: Text(
        'Brands',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
