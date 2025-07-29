import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store/utils/constants/sizes.dart';

class BannerPlaceholder extends StatelessWidget {
  const BannerPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShimmerWidget(
          height: 200,
          width: double.infinity,
          shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TSizes.md),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        ShimmerWidget(
          height: 4,
          width: 20,
          shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(TSizes.md)),
        ),
      ],
    );
  }
}
