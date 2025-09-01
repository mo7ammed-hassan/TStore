import 'package:flutter/material.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';

// ResponsiveText: Text widget responsive based on screen width
// Can use baseStyle from Theme.of(context).textTheme

class ResponsiveText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final TextStyle? style;
  final Color? color;
  final TextAlign? textAlign;
  final double minScale;
  final double maxScale;
  final int? maxLines;
  final TextOverflow? overflow;

  const ResponsiveText(
    this.text, {
    super.key,
    this.fontSize = 15,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.minScale = 0.8,
    this.maxScale = 1.2,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: (style ?? const TextStyle()).copyWith(
        fontSize: getResponsiveFontSize(
          context,
          fontSize: style?.fontSize ?? fontSize,
          minScale: minScale,
          maxScale: maxScale,
        ),
        fontWeight: fontWeight ?? style?.fontWeight,
        color: color ?? style?.color,
      ),
    );
  }
}
