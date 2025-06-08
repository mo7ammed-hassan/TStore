import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TRoundedContainer extends StatelessWidget {
  final double? width, height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;
  final double radius;
  final bool showBorder;
  final Widget? child;
  final Color borderColor;

  const TRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.margin,
    this.backgroundColor = AppColors.white,
    this.radius = AppSizes.cardRadiusLg,
    this.showBorder = false,
    this.child,
    this.borderColor = AppColors.borderPrimary,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
