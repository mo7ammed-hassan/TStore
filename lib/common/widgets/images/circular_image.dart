import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    required this.image,
    this.width = 56,
    this.height = 56,
    this.padding = TSizes.sm,
    this.backgroundColor,
    this.fit = BoxFit.cover,
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
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
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
                      const ShimmerWidget(
                    height: 75,
                    width: 75,
                    shapeBorder: CircleBorder(),
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
