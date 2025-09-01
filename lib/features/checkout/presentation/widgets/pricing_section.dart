import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/divider/custom_divider.dart';
import 'package:t_store/features/checkout/data/models/order_summary_model.dart';
import 'package:t_store/features/payment/presentation/widgets/payment_summary_row.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key, required this.orderSummary});
  final OrderSummaryModel? orderSummary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaymentSummaryRow(
          label: 'Subtotal',
          value: '\$${orderSummary?.subtotal}',
        ),
        ResponsiveGap.vertical(TSizes.spaceBtwItems / 2),
        PaymentSummaryRow(
          label: 'Shipping Free',
          value: '-\$${orderSummary?.discount}',
        ),
        ResponsiveGap.vertical(TSizes.spaceBtwItems / 2),
        PaymentSummaryRow(
          label: 'Tax Free',
          value: '+\$${orderSummary?.shipping}',
        ),
        ResponsiveGap.vertical(TSizes.spaceBtwItems),
        const CustomDivider(),
        ResponsiveGap.vertical(18.0),
        PaymentSummaryRow(
          label: 'Order Total',
          value: '\$${orderSummary?.total.toStringAsFixed(2)}',
        ),
      ],
    );
  }
}
