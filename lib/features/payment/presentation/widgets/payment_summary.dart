import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/divider/custom_divider.dart';
import 'package:t_store/features/checkout/domain/entities/order_summary_entity.dart';
import 'package:t_store/features/payment/presentation/widgets/payment_summary_row.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({super.key, this.orderSummary});
  final OrderSummaryEntity? orderSummary;

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
