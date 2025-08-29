import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/checkout/presentation/cubits/checkout_cubit.dart';
import 'package:t_store/features/checkout/presentation/cubits/checkout_state.dart';
import 'package:t_store/features/payment/presentation/screens/payment_screen.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final total = context.select<CheckoutCubit, double?>((cubit) {
      final state = cubit.state;
      if (state is CheckoutLoaded) {
        return state.orderSummary.total;
      }
      return null;
    });

    if (total == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: context.responsiveInsets.symmetric(
        horizontal: TSizes.defaultSpace,
        vertical: TSizes.spaceBtwItems,
      ),
      child: ElevatedButton(
        onPressed: total > 10
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentScreen(),
                  ),
                );
              }
            : null,
        child: ResponsiveText(
          'Confirm Order \$${total.toStringAsFixed(2)}',
        ),
      ),
    );
  }
}
