import 'package:flutter/material.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';

class TElevetedButtonTheme {
  TElevetedButtonTheme._();

  static ElevatedButtonThemeData lightElevetedButtonTheme(
          BuildContext context) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          // disabledForegroundColor: Colors.grey,
          // disabledBackgroundColor: Colors.grey,
          side: const BorderSide(color: Colors.blue),
          padding: context.responsiveInsets.symmetric(vertical: 16),
          textStyle: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

  static ElevatedButtonThemeData darkElevetedButtonTheme(
          BuildContext context) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          // disabledForegroundColor: Colors.grey,
          // disabledBackgroundColor: Colors.grey,
          side: const BorderSide(color: Colors.blue),
          padding: context.responsiveInsets.symmetric(vertical: 16),
          textStyle: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
}
