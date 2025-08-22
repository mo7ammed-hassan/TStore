import 'package:flutter/material.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRow(
          context,
          label: 'Subtotal:',
          value: '\$120.00',
        ),
        const SizedBox(height: 14),
        Row(
          // --- Divider
          children: List.generate(
            25,
            (index) => Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                height: 1.1,
                color: Color(0xFF5a5e64),
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
        _buildRow(
          context,
          label: 'Total:',
          value: '\$1200.00',
        ),
      ],
    );
  }

  Widget _buildRow(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = HelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textTheme.bodyMedium?.copyWith(
            color: isDark ? Colors.grey : Color(0xFF5a5e64),
            fontSize: 15,
          ),
        ),
        Text(
          value,
          style: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
