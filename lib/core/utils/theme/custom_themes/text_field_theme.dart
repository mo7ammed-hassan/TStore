import 'package:flutter/material.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme(BuildContext context) =>
      InputDecorationTheme(
        errorMaxLines: 1,
        prefixIconColor: Colors.grey,
        suffixIconColor: Colors.grey,
        labelStyle: const TextStyle().copyWith(
            fontSize: getResponsiveFontSize(context, fontSize: 12),
            color: Colors.black),
        hintStyle: const TextStyle().copyWith(
            fontSize: getResponsiveFontSize(context, fontSize: 12),
            color: Colors.black),
        errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
        floatingLabelStyle:
            TextStyle(color: Colors.black.withValues(alpha: 0.8)),
        border: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(
              getResponsiveFontSize(context, fontSize: 12)),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
        enabledBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(
              getResponsiveFontSize(context, fontSize: 12)),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(
              getResponsiveFontSize(context, fontSize: 12)),
          borderSide: const BorderSide(width: 1, color: Colors.black12),
        ),
        errorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(
              getResponsiveFontSize(context, fontSize: 12)),
          borderSide: const BorderSide(width: 1, color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(
              getResponsiveFontSize(context, fontSize: 12)),
          borderSide: const BorderSide(width: 2, color: Colors.orange),
        ),
      );

  static InputDecorationTheme darkInputDecorationTheme(BuildContext context) =>
      InputDecorationTheme(
        errorMaxLines: 1,
        prefixIconColor: Colors.grey,
        suffixIconColor: Colors.grey,
        labelStyle: const TextStyle().copyWith(
            fontSize: getResponsiveFontSize(context, fontSize: 12),
            color: Colors.white),
        hintStyle: const TextStyle().copyWith(
            fontSize: getResponsiveFontSize(context, fontSize: 12),
            color: Colors.white),
        errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
        floatingLabelStyle:
            TextStyle(color: Colors.white.withValues(alpha: 0.8)),
        border: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(
              getResponsiveFontSize(context, fontSize: 12)),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
        enabledBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(
              getResponsiveFontSize(context, fontSize: 12)),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(
              getResponsiveFontSize(context, fontSize: 12)),
          borderSide: const BorderSide(width: 1, color: Colors.white),
        ),
        errorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(
              getResponsiveFontSize(context, fontSize: 12)),
          borderSide: const BorderSide(width: 1, color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(
              getResponsiveFontSize(context, fontSize: 12)),
          borderSide: const BorderSide(width: 2, color: Colors.orange),
        ),
      );
}
