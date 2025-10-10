import 'package:flutter/material.dart';
import 'package:t_store/core/core.dart';

class PaymentSummaryRow extends StatelessWidget {
  const PaymentSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.maxLines,
  });
  final String label, value;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = HelperFunctions.isDarkMode(context);

    return Row(
      children: [
        Expanded(
          child: ResponsiveText(
            label,
            style: textTheme.bodySmall?.copyWith(
              color: isDark ? Colors.grey : const Color(0xFF5a5e64),
              fontSize: 12,
            ),
          ),
        ),
        ResponsiveGap.horizontal(5.0),
        ResponsiveText(
          value,
          maxLines: maxLines,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
