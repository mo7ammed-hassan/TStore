import 'package:flutter/material.dart';

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({super.key});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        _buildRow(
          context,
          label: 'Subtotal:',
          value: '\$120.00',
          style: textTheme.bodyMedium,
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
          value: '\$120.00',
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildRow(BuildContext context,
      {required String label, required String value, TextStyle? style}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Color(0xFF5a5e64), fontSize: 15),
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ],
    );
  }
}
