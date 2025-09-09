import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store/core/utils/constants/images_strings.dart';

class BannerImage extends StatelessWidget {
  const BannerImage({
    super.key,
    required this.imageUrl,
    this.fallbackAssetImage = TImages.defaultProductImage,
  });

  final String imageUrl;
  final String? fallbackAssetImage;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.contain,
        errorWidget: (context, url, error) => errorWidget(),
        placeholder: (context, url) => ShimmerWidget(
          shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget errorWidget() => fallbackAssetImage != null
      ? Image.network(
          fallbackAssetImage!,
          fit: BoxFit.contain,
        )
      : const Icon(Icons.error);
}
