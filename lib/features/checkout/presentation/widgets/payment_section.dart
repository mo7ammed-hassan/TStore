import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/images/rounded_image.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        const TSectionHeading(
          title: 'Payment Method',
          showActionButton: true,
          buttonTitle: 'Change',
          fontSize: 14.5,
        ),
        Row(
          children: [
            TRoundedImage(
              width: 52,
              height: 30,
              backgroundColor: isDark ? AppColors.dark : AppColors.light,
              imageUrl: TImages.visa,
              fit: BoxFit.contain,
              padding: const EdgeInsets.all(2),
              borderRadius: 5,
            ),
            ResponsiveGap.horizontal(TSizes.spaceBtwItems),
            ResponsiveText(
              'Visa',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}
