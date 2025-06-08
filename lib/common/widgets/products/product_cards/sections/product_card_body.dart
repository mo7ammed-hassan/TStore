import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/utils/constants/sizes.dart';

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
      padding: const EdgeInsets.only(left: AppSizes.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TProductTitleText(
            title: title ?? '',
            smallSize: true,
          ),
          const SizedBox(height: AppSizes.spaceBtwItems / 2),
          TBrandTitleWithVerifiedIcon(title: brandTitle ?? ''),
        ],
      ),
    );
  }
}
