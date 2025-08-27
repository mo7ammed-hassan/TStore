import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';

class TReadMoreText extends StatelessWidget {
  const TReadMoreText({
    super.key,
    required this.text,
    this.trimLines = 2,
    this.trimMode = TrimMode.Line,
    this.trimCollapsedText = ' Show more',
    this.trimExpandedText = ' Show less',
  });
  final String text;
  final int trimLines;
  final TrimMode trimMode;
  final String trimCollapsedText, trimExpandedText;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimLines: trimLines,
      trimMode: trimMode,
      trimCollapsedText: trimCollapsedText,
      trimExpandedText: trimExpandedText,
      preDataTextStyle: TextStyle(
        fontSize: getResponsiveFontSize(context, fontSize: 11),
        fontWeight: FontWeight.bold,
      ),
      moreStyle: TextStyle(
        fontSize: getResponsiveFontSize(context, fontSize: 11),
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
      lessStyle: TextStyle(
        fontSize: getResponsiveFontSize(context, fontSize: 11),
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }
}
