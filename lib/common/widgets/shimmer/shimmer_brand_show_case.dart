import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_brand_card.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';

class ShimmerBrandShowCase extends StatelessWidget {
  const ShimmerBrandShowCase({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: context.responsiveInsets.all(TSizes.md),
      backgroundColor: Colors.transparent,
      showBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBrandCard(showBorder: false),
          ResponsiveGap.vertical(TSizes.spaceBtwItems),
          Row(
            children: List.generate(
              3,
              (index) => Expanded(
                child: TRoundedContainer(
                  height: context.horzSize(85),
                  width: context.horzSize(85),
                  backgroundColor: HelperFunctions.isDarkMode(context)
                      ? AppColors.darkerGrey
                      : AppColors.light,
                  margin: context.responsiveInsets.only(right: TSizes.sm),
                  padding: const EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                    child: ShimmerWidget(
                      height: context.horzSize(85),
                      width: context.horzSize(85),
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
