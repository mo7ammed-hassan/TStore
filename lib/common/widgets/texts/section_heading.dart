import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class TSectionHeading extends StatelessWidget {
  final String title, buttonTitle;
  final Color? textColor;
  final bool showActionButton;
  final void Function()? onPressed;
  final double? fontSize;

  const TSectionHeading({
    super.key,
    required this.title,
    this.buttonTitle = 'View All',
    this.showActionButton = true,
    this.onPressed,
    this.textColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ResponsiveText(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: fontSize ?? 15.5,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(
            onPressed: onPressed,
            child: ResponsiveText(
              buttonTitle,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.primary,
                    fontSize: (fontSize ?? 15.5) - 2,
                  ),
            ),
          )
      ],
    );
  }
}
