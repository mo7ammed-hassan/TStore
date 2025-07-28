import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TRoundedImage extends StatelessWidget {
  final String imageUrl;
  final double? width, height;
  final double borderRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit fit;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool aplayImageRaduis, isNetworkImage;

  const TRoundedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.borderRadius = TSizes.md,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.onTap,
    this.aplayImageRaduis = true,
    this.isNetworkImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: aplayImageRaduis
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: fit,
                  errorWidget: (context, url, error) => Image.network(
                        TImages.defaultProductImage,
                        fit: fit,
                      ))
              : Image.asset(
                  imageUrl,
                  fit: fit,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
        ),
      ),
    );
  }
}
