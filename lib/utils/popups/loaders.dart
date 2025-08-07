import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/colors.dart';
import '../helpers/helper_functions.dart';

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
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
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

  static void successSnackBar(
      {required String title, message = '', duration = 3}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: AppColors.primary,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: const Icon(Iconsax.check, color: AppColors.white),
    );
  }

  static void warningSnackBar({required String title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppColors.white,
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: AppColors.white),
    );
  }

  static void errorSnackBar({required String title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppColors.white,
      backgroundColor: Colors.red.shade600,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: AppColors.white),
    );
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
      throw Exception("Context is not available yet!");
    }
    return navigatorKey.currentContext!;
  }
}
