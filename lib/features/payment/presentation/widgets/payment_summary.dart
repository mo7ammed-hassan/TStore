import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/divider/custom_divider.dart';
import 'package:t_store/features/checkout/data/models/order_summary_model.dart';
import 'package:t_store/features/payment/presentation/widgets/payment_summary_row.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({super.key, this.orderSummary});
  final OrderSummaryModel? orderSummary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaymentSummaryRow(
          label: 'Subtotal:',
          value: '\$${orderSummary?.subtotal}',
        ),
        ResponsiveGap.vertical(14.0),
        const CustomDivider(),
        ResponsiveGap.vertical(18.0),
        PaymentSummaryRow(
          label: 'Total:',
          value: '\$${orderSummary?.total}',
        ),
      ],
    );
  }
}
