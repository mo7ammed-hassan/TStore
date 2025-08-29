import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/checkout/presentation/cubits/checkout_cubit.dart';
import 'package:t_store/features/checkout/presentation/cubits/checkout_state.dart';
import 'package:t_store/features/payment/presentation/screens/payment_screen.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.responsiveInsets.symmetric(
        horizontal: TSizes.defaultSpace,
        vertical: TSizes.spaceBtwItems,
      ),
      child: BlocConsumer<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          if (state.createOrderSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentScreen(
                  orderSummary: state.checkoutData?.orderSummary,
                ),
              ),
            );

            context.read<CartCubit>().clearAllItems();
          }
        },
        builder: (context, state) {
          final double? total = state.checkoutData?.orderSummary.total;
          return ElevatedButton(
            onPressed: total != 0
                ? () {
                    if (state.checkoutData != null) {
                      context
                          .read<CheckoutCubit>()
                          .createOrderDraft(state.checkoutData!);
                    }
                  }
                : null,
            child: state.createOrderLoading
                ? SizedBox(
                    width: context.horzSize(20),
                    height: context.horzSize(20),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    ),
                  )
                : ResponsiveText(
                    'Confirm Order \$${total?.toStringAsFixed(2)}',
                  ),
          );
        },
      ),
    );
  }
}
