import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/divider/custom_divider.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/features/shop/features/payment/presentation/widgets/payment_summary_row.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.watch<CartCubit>();
    cartCubit.calcOrderTotal(10.0, 6.0);

    return Column(
      children: [
        PaymentSummaryRow(
          label: 'Subtotal',
          value: '\$${cartCubit.totalPrice}',
        ),
        ResponsiveGap.vertical(TSizes.spaceBtwItems / 2),
        PaymentSummaryRow(
          label: 'Shipping Free',
          value: '\$6.0',
        ),
        ResponsiveGap.vertical(TSizes.spaceBtwItems / 2),
        PaymentSummaryRow(
          label: 'Tax Free',
          value: '\$10.0',
        ),
        ResponsiveGap.vertical(TSizes.spaceBtwItems),
        const CustomDivider(),
        ResponsiveGap.vertical(18.0),
        PaymentSummaryRow(
          label: 'Order Total',
          value: '\$${cartCubit.orderTotal.toStringAsFixed(2)}',
        ),
      ],
    );
  }
}
