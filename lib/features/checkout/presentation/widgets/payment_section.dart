import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/images/rounded_image.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/images_strings.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

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
              backgroundColor: isDark ? AppColors.darkerGrey : AppColors.light,
              imageUrl: TImages.visa,
              fit: BoxFit.contain,
              padding: const EdgeInsets.all(8),
              borderRadius: 4,
            ),
            ResponsiveGap.horizontal(10),
            ResponsiveText(
              'Visa',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }
}
