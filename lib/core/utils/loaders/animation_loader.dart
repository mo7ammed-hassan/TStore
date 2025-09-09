import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';

/// A widget for displaying an animated loading indicator with optional text and action button.
class TAnimationLoaderWidget extends StatelessWidget {
  /// Default constructor for the TAnimationLoaderWidget.
  ///
  /// Parameters:
  ///   - text: The text to be displayed below the animation.
  ///   - animation: The path to the Lottie animation file.
  ///   - showAction: Whether to show an action button below the text.
  ///   - actionText: The text to be displayed on the action button.
  ///   - onActionPressed: Callback function to be executed when the action button is pressed.
  const TAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
    this.toHeight = 0.06,
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;
  final double toHeight;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height * toHeight),
          Lottie.asset(
            animation,
            width: MediaQuery.of(context).size.width * 0.8,
          ), // Display Lottie animation
          ResponsiveGap.vertical(TSizes.defaultSpace),
          ResponsiveText(
            text,
            style:
                Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 13.5),
            textAlign: TextAlign.center,
          ),
          ResponsiveGap.vertical(TSizes.defaultSpace),
          showAction
              ? SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.7,
                  child: OutlinedButton(
                    onPressed: onActionPressed,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: isDark ? Colors.white : Colors.black,
                      backgroundColor:
                          isDark ? null : AppColors.primaryBackground,
                    ),
                    child: ResponsiveText(
                      actionText!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
