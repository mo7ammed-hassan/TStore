import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';

void showEnlargedImage(String image, BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Dialog.fullscreen(
      insetAnimationDuration: const Duration(microseconds: 850),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: context.responsiveInsets.symmetric(
              vertical: TSizes.defaultSpace * 2,
              horizontal: TSizes.defaultSpace,
            ),
            child: CachedNetworkImage(
              imageUrl: image,
              alignment: Alignment.center,
              fit: BoxFit.contain,
            ),
          ),
          ResponsiveGap.vertical(TSizes.spaceBtwSections),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: context.horzSize(150),
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
