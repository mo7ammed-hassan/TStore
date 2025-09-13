import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class TDiscountRate extends StatelessWidget {
  const TDiscountRate({
    super.key,
    required this.rate,
  });
  final String rate;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.responsiveInsets.symmetric(
        horizontal: TSizes.sm,
        vertical: TSizes.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(TSizes.sm),
      ),
      child: ResponsiveText(
        rate,
        style: Theme.of(context).textTheme.labelLarge!.apply(
              color: AppColors.black,
            ),
      ),
    );
  }
}
