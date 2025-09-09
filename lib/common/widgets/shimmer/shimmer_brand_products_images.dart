import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';

class ShimmerBrandProductsImages extends StatelessWidget {
  const ShimmerBrandProductsImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        3,
        (index) => Expanded(
          child: TRoundedContainer(
            height: context.vertSize(85),
            width: context.vertSize(85),
            backgroundColor: HelperFunctions.isDarkMode(context)
                ? AppColors.darkerGrey
                : AppColors.light,
            margin: context.responsiveInsets.only(right: TSizes.sm),
            padding: context.responsiveInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
              child: const ShimmerWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
