import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/sizes.dart';

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
            padding: const EdgeInsets.symmetric(
              vertical: TSizes.defaultSpace * 2,
              horizontal: TSizes.defaultSpace,
            ),
            child: CachedNetworkImage(
              imageUrl: image,
              alignment: Alignment.center,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 150,
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
