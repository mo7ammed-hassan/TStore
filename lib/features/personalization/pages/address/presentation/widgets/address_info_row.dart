import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class AddressInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const AddressInfoRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: context.horzSize(18)),
        ResponsiveGap.horizontal(TSizes.spaceBtwItems),
        Expanded(
          child: ResponsiveText(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 13.5),
          ),
        ),
      ],
    );
  }
}
