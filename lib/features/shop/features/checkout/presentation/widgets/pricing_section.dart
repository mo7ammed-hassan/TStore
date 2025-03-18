import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/checkout/presentation/cubits/checkout_cubit.dart';
import 'package:t_store/utils/constants/sizes.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});
  @override
  Widget build(BuildContext context) {
    final cuit = context.read<CheckoutCubit>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$${cuit.calculateSubTotalAmount().toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Free',
                style: Theme.of(context).textTheme.bodyMedium),
            Text('\$6.0', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Free', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$10.0', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              child: Text(
                'Order Total',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(width: AppSizes.md),
            FittedBox(
              child: Text(
                '\$${cuit.calculateTotalAmount().toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
