import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/texts/read_more_text.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class StoreResponse extends StatelessWidget {
  const StoreResponse({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TRoundedContainer(
      padding: const EdgeInsets.all(AppSizes.md),
      backgroundColor: isDark ? AppColors.darkerGrey : AppColors.grey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'T\'Store',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '20 Nov 2024',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          const TReadMoreText(
            text:
                'Ratings and reviews are verified and are from people who use the same type of product that you see,, Ratings and reviews are verified',
          ),
        ],
      ),
    );
  }
}
