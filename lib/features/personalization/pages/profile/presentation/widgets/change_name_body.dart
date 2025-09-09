import 'package:flutter/material.dart';
import 'package:t_store/features/personalization/pages/profile/presentation/widgets/change_name_form.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class ChangeNameBody extends StatelessWidget {
  const ChangeNameBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveText(
          'Enter your real name for verification purposes. This name will appear on multiple pages.',
          maxLines: 5,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        ResponsiveGap.vertical(TSizes.spaceBtwSections),
        const ChangeNameForm(),
      ],
    );
  }
}
