import 'package:flutter/material.dart';
import 'package:t_store/features/shop/features/payment/presentation/widgets/payment_summary_row.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaymentSummaryRow(
          label: 'Subtotal:',
          value: '\$120.00',
        ),
        ResponsiveGap.vertical(14.0),

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
        ResponsiveGap.vertical(18.0),
        
        PaymentSummaryRow(
          label: 'Total:',
          value: '\$1200.00',
        ),
      ],
    );
  }
}
