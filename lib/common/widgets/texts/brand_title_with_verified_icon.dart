import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/texts/brand_title_text.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TBrandTitleWithVerifiedIcon extends StatelessWidget {
  final String title;
  final Color iconColor;
  final int maxLines;
  final TextAlign? textAlign;
  final Color? textColor;
  final TextSizes brandTextSize;

  const TBrandTitleWithVerifiedIcon({
    super.key,
    required this.title,
    this.iconColor = AppColors.primary,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.textColor,
    this.brandTextSize = TextSizes.small,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TBrandTitleText(
            title: title,
            maxLines: maxLines,
            textAlign: textAlign,
            color: textColor,
            brandTextSize: brandTextSize,
          ),
        ),
        const SizedBox(width: AppSizes.xs),
        Icon(
          Iconsax.verify5,
          color: iconColor,
          size: AppSizes.iconXs,
        )
      ],
    );
  }
}
