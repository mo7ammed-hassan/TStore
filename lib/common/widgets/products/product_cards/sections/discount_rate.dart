import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class TDiscountRate extends StatelessWidget {
  const TDiscountRate({
    super.key,
    required this.rate,
  });
  final String rate;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: context.responsiveInsets.symmetric(
        horizontal: TSizes.sm,
        vertical: TSizes.xs,
      ),
      radius: TSizes.sm,
      backgroundColor: AppColors.secondary.withValues(alpha: 0.8),
      child: ResponsiveText(
        rate,
        style: Theme.of(context).textTheme.labelLarge!.apply(
              color: AppColors.black,
            ),
      ),
    );
  }
}
