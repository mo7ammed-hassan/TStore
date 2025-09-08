import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/checkout/presentation/cubits/checkout_cubit.dart';
import 'package:t_store/features/checkout/presentation/cubits/checkout_state.dart';
import 'package:t_store/features/payment/presentation/screens/select_payment_screen.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class ConfirmOrderButton extends StatelessWidget {
  const ConfirmOrderButton({
    super.key,
    this.removeCartItems = false,
    required this.order,
  });
  final bool removeCartItems;
  final OrderEntity? order;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
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
                  builder: (context) => SelectPaymentScreen(
                    order: state.order ?? order,
                  ),
                ),
              );

              if (removeCartItems) context.read<CartCubit>().clearAllItems();
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
                            .createOrderDraft(state.checkoutData!, order);
                      }
                    }
                  : null,
              child: state.createOrderLoading ||
                      (state.status == CheckoutStatus.loading)
                  ? SizedBox(
                      width: context.horzSize(20),
                      height: context.horzSize(20),
                      child: const Center(
                        child: PopScope(
                          canPop: false,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        ),
                      ),
                    )
                  : ResponsiveText(
                      'Confirm Order \$${total?.toStringAsFixed(2) ?? 0}',
                    ),
            );
          },
        ),
      ),
    );
  }
}
