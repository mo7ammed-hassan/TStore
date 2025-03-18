import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TDiscountRate extends StatelessWidget {
  const TDiscountRate({
    super.key,
    required this.rate,
  });
  final String rate;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.sm,
        vertical: AppSizes.xs,
      ),
      radius: AppSizes.sm,
      backgroundColor: AppColors.secondary.withValues(alpha: 0.8),
      child: Text(
        rate,
        style: Theme.of(context).textTheme.labelLarge!.apply(
              color: AppColors.black,
            ),
      ),
    );
  }
}
