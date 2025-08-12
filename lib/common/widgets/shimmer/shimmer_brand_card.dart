import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_verify_brand.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class ShimmerBrandCard extends StatelessWidget {
  const ShimmerBrandCard({super.key, this.showBorder = true, this.borderColor});
  final bool showBorder;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: showBorder
            ? Border.all(
                color: borderColor ??
                    (isDark ? AppColors.darkGrey : AppColors.grey),
              )
            : null,
      ),
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: ShimmerWidget(
              width: 45,
              height: 45,
              shapeBorder: CircleBorder(),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            fit: FlexFit.loose,
            child: FittedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerVerifyBrand(),
                  ShimmerWidget(
                    height: 9,
                    width: 95,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
