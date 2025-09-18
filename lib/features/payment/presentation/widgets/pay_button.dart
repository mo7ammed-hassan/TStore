import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/core.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/payment/payment.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';

class PayButton extends StatelessWidget {
  const PayButton({
    super.key,
    required this.order,
    this.paymentMethodId,
    required this.cvc,
  });
  final OrderEntity order;
  final String? paymentMethodId;
  final String cvc;

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>().state.user;

    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
            ),
            onPressed: () {
              if (cvc.isEmpty) {
                Loaders.warningSnackBar(
                  title: 'CVC',
                  message: 'Please enter CVC',
                );

                return;
              }
              final userData = PaymentUserDataModel(
                customerId: user?.stripeCustomerId,
              );
              final details = PaymentDetails(
                orderId: order.orderId,
                currency: 'usd',
                amountMinor: order.checkoutModel.total.toInt(),
                paymentMethodId: paymentMethodId,
                user: userData,
                cvc: cvc,
              );

              context
                  .read<PaymentCubit>()
                  .confirmPayment(details, order, cardFlow: CardFlow.savedCard);
            },
            child: state.status == PaymentStateStatus.loading &&
                    state.action == PaymentAction.processPayment
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
                : const ResponsiveText('Pay'),
          );
        },
      ),
    );
  }
}
