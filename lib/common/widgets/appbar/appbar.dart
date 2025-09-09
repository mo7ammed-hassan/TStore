import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final bool showBackArrow;
  final Color? titleColor;
  final double fontSize;
  final bool? centerTitle;
  final bool nestedNavigator;

  const TAppBar({
    super.key,
    this.title,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.showBackArrow = false,
    this.titleColor,
    this.fontSize = 18,
    this.centerTitle,
    this.nestedNavigator = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Padding(
      padding: context.responsiveInsets.symmetric(horizontal: TSizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: centerTitle,
        leadingWidth: context.horzSize(38),
        leading: showBackArrow
            ? IconButton(
                onPressed: () {
                  nestedNavigator
                      ? Navigator.of(context, rootNavigator: false).pop()
                      : Navigator.of(context, rootNavigator: true).pop();
                  leadingOnPressed?.call();
                },
                icon: Icon(
                  Iconsax.arrow_left,
                  color: isDark ? AppColors.white : AppColors.dark,
                ),
              )
            : leadingIcon != null
                ? IconButton(
                    onPressed: leadingOnPressed,
                    icon: Icon(leadingIcon),
                  )
                : null,
        title: (title != null)
            ? ResponsiveText(
                title!,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: fontSize, color: titleColor),
              )
            : null,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
