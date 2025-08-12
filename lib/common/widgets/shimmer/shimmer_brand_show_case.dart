import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_brand_card.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class ShimmerBrandShowCase extends StatelessWidget {
  const ShimmerBrandShowCase({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.md),
      backgroundColor: Colors.transparent,
      showBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBrandCard(showBorder: false),
          const SizedBox(height: TSizes.spaceBtwItems),
          Row(
            children: List.generate(
              3,
              (index) => Expanded(
                child: TRoundedContainer(
                  height: 100,
                  backgroundColor: HelperFunctions.isDarkMode(context)
                      ? AppColors.darkerGrey
                      : AppColors.light,
                  margin: const EdgeInsets.only(right: TSizes.sm),
                  padding: const EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                    child: ShimmerWidget(
                      height: 100,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
