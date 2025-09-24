import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/core.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/checkout/presentation/cubits/checkout_cubit.dart';
import 'package:t_store/features/checkout/presentation/cubits/checkout_state.dart';
import 'package:t_store/features/payment/presentation/routes/payment_routes.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';

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
      top: false,
      child: Padding(
        padding: context.responsiveInsets.symmetric(
          horizontal: TSizes.defaultSpace,
          vertical: TSizes.spaceBtwItems,
        ),
        child: BlocConsumer<CheckoutCubit, CheckoutState>(
          listener: (context, state) {
            if (state.createOrderSuccess) {
              Navigator.of(context).pushNamed(
                PaymentRoutes.selectPaymentScreen,
                arguments: state.order ?? order,
              );

              if (removeCartItems) context.read<CartCubit>().clearAllItems();
            }
          },
          builder: (context, state) {
            final double? total = state.checkoutData?.orderSummary.total;
            return ElevatedButton(
              onPressed: total != 0
                  ? () {
                      if (state.address?.id.isEmpty ?? true) {
                        Loaders.warningSnackBar(
                          title: 'No Shipping Address',
                          message:
                              'Please add a shipping address before confirming the order.',
                        );
                        return;
                      }
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
                            strokeWidth: 2.2,
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
