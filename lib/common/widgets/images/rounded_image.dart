import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store/core/utils/constants/images_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';

class TRoundedImage extends StatelessWidget {
  final String imageUrl;
  final double? width, height;
  final double borderRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit fit;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool applyImageRadius;
  final String? fallbackAssetImage;
  final EdgeInsetsGeometry? margin;

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
    this.margin,
    this.onTap,
    this.applyImageRadius = true,
    this.fallbackAssetImage = TImages.defaultProductImage,
  });

  bool get _isNetworkImage =>
      imageUrl.startsWith('http') || imageUrl.startsWith('https');

  @override
  Widget build(BuildContext context) {
    final double? finalWidth = width != null ? context.horzSize(width!) : null;
    final double? finalHeight =
        height != null ? context.horzSize(height!) : null;

    Widget errorWidget = fallbackAssetImage != null
        ? Image.network(
            fallbackAssetImage!,
            fit: fit,
            width: finalWidth,
            height: finalHeight,
          )
        : const Icon(Icons.error);

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: applyImageRadius
            ? BorderRadius.circular(borderRadius + 5)
            : BorderRadius.zero,
        child: Container(
          width: finalWidth,
          height: finalHeight,
          padding: padding,
          margin: margin,
          decoration: BoxDecoration(
            border: border,
            color: backgroundColor,
            borderRadius: applyImageRadius
                ? BorderRadius.circular(borderRadius + 5)
                : BorderRadius.zero,
          ),
          child: _isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: fit,
                  width: finalWidth,
                  height: finalHeight,
                  errorWidget: (context, url, error) => errorWidget,
                  placeholder: (context, url) => ShimmerWidget(
                    width: finalWidth,
                    height: finalHeight,
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                  ),
                )
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
