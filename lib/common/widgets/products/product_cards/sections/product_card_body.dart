import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';

class TProductCardBody extends StatelessWidget {
  const TProductCardBody({
    super.key,
    this.title,
    this.brandTitle,
  });
  final String? title, brandTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.responsiveInsets.only(left: TSizes.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TProductTitleText(
            title: title ?? '',
            smallSize: true,
          ),
          ResponsiveGap.vertical(TSizes.spaceBtwItems / 2),
          TBrandTitleWithVerifiedIcon(title: brandTitle ?? ''),
        ],
      ),
    );
  }
}
