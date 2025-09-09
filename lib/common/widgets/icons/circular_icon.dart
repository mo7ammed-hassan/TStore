import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';

class TCircularIcon extends StatelessWidget {
  final IconData icon;
  final Color? backgroundColor;
  final Color? color;
  final VoidCallback? onPressed;
  final double? width, height, size;
  const TCircularIcon({
    super.key,
    required this.icon,
    this.backgroundColor,
    this.onPressed,
    this.width,
    this.height,
    this.size = TSizes.lg,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return InkWell(
      onTap: onPressed,
      customBorder: const CircleBorder(),
      child: Container(
        width: width != null ? context.horzSize(width!) : null,
        height: height != null ? context.horzSize(height!) : null,
        padding: context.responsiveInsets.all(7.0),
        decoration: BoxDecoration(
          color: backgroundColor != null
              ? backgroundColor!
              : isDark
                  ? AppColors.black.withValues(alpha: 0.9)
                  : AppColors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Center(
            child: Icon(
              icon,
              size: size != null ? context.horzSize(size!) : null,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
