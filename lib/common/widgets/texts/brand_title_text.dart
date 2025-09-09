import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/enums.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class TBrandTitleText extends StatelessWidget {
  const TBrandTitleText({
    super.key,
    this.color,
    this.maxLines = 1,
    required this.title,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final Color? color;
  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return ResponsiveText(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      // Check which brandSize is required and set that style.
      style: brandTextSize == TextSizes.small
          ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
          : brandTextSize == TextSizes.medium
              ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
              : brandTextSize == TextSizes.large
                  ? Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: color)
                      .copyWith(fontWeight: FontWeight.w500)
                  : Theme.of(context).textTheme.bodyMedium!.apply(color: color),
    );
  }
}
