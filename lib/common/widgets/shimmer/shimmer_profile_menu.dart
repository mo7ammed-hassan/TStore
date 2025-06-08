import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class ShimmerProfileMenu extends StatelessWidget {
  const ShimmerProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      period: const Duration(milliseconds: 1550),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 5,
              child: Container(
                height: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const Expanded(
              child: Icon(
                Iconsax.arrow_right_34,
                size: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
