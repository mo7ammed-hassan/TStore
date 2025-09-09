import 'package:flutter/material.dart';
import 'package:t_store/core/utils/theme/custom_themes/appbar_theme.dart';
import 'package:t_store/core/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:t_store/core/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:t_store/core/utils/theme/custom_themes/chip_theme.dart';
import 'package:t_store/core/utils/theme/custom_themes/eleveted_button_theme.dart';
import 'package:t_store/core/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:t_store/core/utils/theme/custom_themes/text_field_theme.dart';
import 'package:t_store/core/utils/theme/custom_themes/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme(BuildContext context) => ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TTextTheme.lightTextTheme,
        chipTheme: TChipTheme.lightChipTheme,
        elevatedButtonTheme: TElevetedButtonTheme.lightElevetedButtonTheme(context),
        appBarTheme: TAppBarTheme.lightAppBarTheme,
        bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
        checkboxTheme: TCheckboxTheme.lightCheckBoxTheme,
        outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
        inputDecorationTheme:
            TTextFormFieldTheme.lightInputDecorationTheme(context),
      );
  static ThemeData darkTheme(BuildContext context) => ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TTextTheme.darkTextTheme,
        chipTheme: TChipTheme.darkChipTheme,
        elevatedButtonTheme: TElevetedButtonTheme.darkElevetedButtonTheme(context),
        appBarTheme: TAppBarTheme.darkAppBarTheme,
        bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
        checkboxTheme: TCheckboxTheme.darkCheckBoxTheme,
        outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
        inputDecorationTheme:
            TTextFormFieldTheme.darkInputDecorationTheme(context),
      );
}
