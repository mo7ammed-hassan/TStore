import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';

class Loaders {
  static void hideSnackBar() =>
      ScaffoldMessenger.of(AppContext.context).hideCurrentSnackBar();

  static void customToast({required String message, bool isMedium = true}) {
    ScaffoldMessenger.of(AppContext.context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: HelperFunctions.isDarkMode(AppContext.context)
                ? AppColors.darkerGrey.withValues(alpha: 0.9)
                : AppColors.grey.withValues(alpha: 0.9),
          ),
          child: Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: isMedium
                  ? Theme.of(AppContext.context).textTheme.bodyMedium
                  : Theme.of(AppContext.context).textTheme.labelLarge,
            ),
          ),
        ),
      ),
    );
  }

  static void successSnackBar({
    required String title,
    String message = '',
    int duration = 2,
  }) {
    _showBaseSnackBar(
      title: title,
      message: message,
      backgroundColor: AppColors.primary,
      icon: Iconsax.check,
      duration: duration,
    );
  }

  static void warningSnackBar({
    required String title,
    String message = '',
    int duration = 2,
  }) {
    _showBaseSnackBar(
      title: title,
      message: message,
      backgroundColor: Colors.orange,
      icon: Iconsax.warning_2,
      duration: duration,
    );
  }

  static void errorSnackBar({
    required String title,
    String message = '',
    int duration = 2,
  }) {
    _showBaseSnackBar(
      title: title,
      message: message,
      backgroundColor: Colors.red.shade600,
      icon: Iconsax.warning_2,
      duration: duration,
    );
  }

  /// private helper method
  static void _showBaseSnackBar({
    required String title,
    required String message,
    required Color backgroundColor,
    required IconData icon,
    required int duration,
  }) {
    final context = AppContext.context;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: Duration(seconds: duration),
        content: Container(
          padding: context.responsiveInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: backgroundColor.withValues(alpha: 0.9),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white),
              ResponsiveGap.horizontal(12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveText(
                      title,
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white, fontSize: 14),
                    ),
                    if (message.isNotEmpty)
                      ResponsiveText(
                        message,
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.white70, fontSize: 12),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void hideLoading() {
    if (Navigator.of(AppContext.context).canPop()) {
      Navigator.of(AppContext.context, rootNavigator: true).pop();
    }
  }
}

class AppContext {
  AppContext._();
  // Singleton Instance
  static final AppContext instance = AppContext._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context {
    if (navigatorKey.currentContext == null) {
      throw Exception('Context is not available yet!');
    }
    return navigatorKey.currentContext!;
  }
}
