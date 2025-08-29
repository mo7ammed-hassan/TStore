import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/divider/custom_divider.dart';
import 'package:t_store/features/payment/presentation/widgets/payment_summary_row.dart';
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

        CustomDivider(),
        ResponsiveGap.vertical(18.0),
        
        PaymentSummaryRow(
          label: 'Total:',
          value: '\$1200.00',
        ),
      ],
    );
  }
}
