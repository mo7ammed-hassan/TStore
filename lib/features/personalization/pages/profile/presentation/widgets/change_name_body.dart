import 'package:flutter/material.dart';
import 'package:t_store/features/personalization/pages/profile/presentation/widgets/change_name_form.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ChangeNameBody extends StatelessWidget {
  const ChangeNameBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter your real name for verification purposes. This name will appear on multiple pages.',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),
        const ChangeNameForm(),
      ],
    );
  }
}
