import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    required this.image,
    this.width = 56,
    this.height = 56,
    this.padding = TSizes.sm,
    this.backgroundColor,
    this.fit = BoxFit.scaleDown,
    this.isNetworkImage = true,
    this.imageColor,
  });

  final String image;
  final double width, height, padding;

  final Color? backgroundColor;
  final Color? imageColor;
  final BoxFit fit;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Container(
      width: context.horzSize(width),
      height: context.horzSize(height),
      padding: context.responsiveInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? (isDark ? AppColors.black : AppColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: image,
                  fit: fit,
                  color: (isDark ? AppColors.light : AppColors.dark),
                  progressIndicatorBuilder: (context, url, progress) =>
                      ShimmerWidget(
                    height: context.horzSize(75),
                    width: context.horzSize(75),
                    shapeBorder: const CircleBorder(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : Image(
                  fit: fit,
                  image: AssetImage(image),
                  color: imageColor,
                ),
        ),
      ),
    );
  }
}
