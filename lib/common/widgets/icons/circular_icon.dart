import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

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
      customBorder: CircleBorder(),
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: backgroundColor != null
              ? backgroundColor!
              : isDark
                  ? AppColors.black.withValues(alpha: 0.9)
                  : AppColors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: size, color: color),
      ),
    );
  }
}
