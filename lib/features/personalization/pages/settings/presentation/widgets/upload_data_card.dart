import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class UploadDataCard extends StatelessWidget {
  final IconData leadingIcon;
  final IconData trailingIcon;
  final String title;
  final String? subtitle;
  final Function()? onTap;

  const UploadDataCard({
    super.key,
    required this.leadingIcon,
    this.trailingIcon = Iconsax.arrow_circle_up,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leadingIcon,
          color: AppColors.primary, size: context.horzSize(26)),
      trailing: Icon(trailingIcon,
          color: AppColors.primary, size: context.horzSize(23)),
      title: ResponsiveText(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.w500),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: subtitle != null ? ResponsiveText(subtitle!) : null,
      onTap: onTap,
    );
  }
}
