import 'package:flutter/material.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';

class ResponsiveTextSpan extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final FontWeight? fontWeight;
  final Color? color;
  final double fontSize;
  final double minScale;
  final double maxScale;
  final TextAlign textAlign;
  final List<ResponsiveTextSpan>? children;

  const ResponsiveTextSpan({
    super.key,
    required this.text,
    this.style,
    this.fontWeight,
    this.color,
    this.fontSize = 16,
    this.minScale = 0.8,
    this.maxScale = 1.2,
    this.textAlign = TextAlign.start,
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        text: text,
        style: (style ?? TextStyle()).copyWith(
          fontSize: getResponsiveFontSize(
            context,
            fontSize: style?.fontSize ?? fontSize,
            minScale: minScale,
            maxScale: maxScale,
          ),
          fontWeight: fontWeight ?? style?.fontWeight,
          color: color ?? style?.color,
        ),
        children: children
            ?.map((child) => child.buildTextSpan(context))
            .toList(),
      ),
    );
  }

  TextSpan buildTextSpan(BuildContext context) {
    return TextSpan(
      text: text,
      style: (style ?? TextStyle()).copyWith(
        fontSize: getResponsiveFontSize(
          context,
          fontSize: style?.fontSize ?? fontSize,
          minScale: minScale,
          maxScale: maxScale,
        ),
        fontWeight: fontWeight ?? style?.fontWeight,
        color: color ?? style?.color,
      ),
      children: children?.map((child) => child.buildTextSpan(context)).toList(),
    );
  }
}
