import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/responsive/responsive.dart';

class LoadingDialog {
  static void show(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: Dialog(
          constraints: const BoxConstraints(),
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? AppColors.dark.withValues(alpha: 0.92)
              : AppColors.light.withValues(alpha: 0.85),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: context.responsiveInsets
                .symmetric(vertical: 30, horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ResponsiveGap.vertical(5),
                SizedBox(
                  width: context.horzSize(30),
                  height: context.horzSize(30),
                  child: const CircularProgressIndicator(
                    color: AppColors.primary,
                    strokeWidth: 2.9,
                  ),
                ),
                if (message != null) ...[
                  ResponsiveGap.vertical(20),
                  ResponsiveText(
                    message,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    textAlign: TextAlign.center,
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
