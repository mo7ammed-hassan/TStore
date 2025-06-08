import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/sizes.dart';

void showEnlargedImage(String image, BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Dialog.fullscreen(
      insetAnimationDuration: const Duration(microseconds: 850),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.defaultSpace * 2,
              horizontal: AppSizes.defaultSpace,
            ),
            child: Image(
              image: AssetImage(image),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
          Align(
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
