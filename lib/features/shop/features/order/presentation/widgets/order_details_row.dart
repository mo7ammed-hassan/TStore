import 'package:flutter/material.dart';
import 'package:t_store/core/core.dart';

class OrderDetailsRow extends StatelessWidget {
  const OrderDetailsRow({
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveText(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: isDark ? Colors.grey : const Color(0xFF5a5e64),
            fontSize: 14,
          ),
        ),
        ResponsiveGap.horizontal(8.0),
        Expanded(
          child: ResponsiveText(
            value,
            maxLines: maxLines,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 13.3,
            ),
          ),
        ),
      ],
    );
  }
}
