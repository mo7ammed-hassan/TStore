import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';

class TRoundedContainer extends StatelessWidget {
  final double? width, height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;
  final double radius;
  final bool showBorder;
  final Widget? child;
  final Color? borderColor;
  final AlignmentGeometry? alignment;

  const TRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.margin,
    this.backgroundColor = AppColors.white,
    this.radius = TSizes.cardRadiusLg,
    this.showBorder = false,
    this.child,
    this.borderColor,
    this.padding,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      alignment: alignment,
      decoration: BoxDecoration(
        color: isDark ? AppColors.dark : backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder
            ? Border.all(
                color: borderColor ??
                    (isDark ? AppColors.darkGrey : AppColors.grey),
              )
            : null,
      ),
      child: child,
    );
  }
}
