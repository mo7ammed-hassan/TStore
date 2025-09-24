import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/core.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/payment/domain/entities/payment_user_data_entity.dart';
import 'package:t_store/features/payment/payment.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';

class PayButton extends StatelessWidget {
  const PayButton({
    super.key,
    required this.order,
    this.paymentMethod,
    required this.validateCVC,
  });
  final OrderEntity order;
  final PaymentMethodEntity? paymentMethod;
  final String? Function()? validateCVC;

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>().state.user;
    print('card type: ${paymentMethod?.cardType}');

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
              final cvc = validateCVC?.call();
              if (cvc == null) {
                return;
              }

              final userData = PaymentUserDataEntity(
                customerId: user?.stripeCustomerId,
              );

              final details = PaymentDetailsEntity(
                orderId: order.orderId,
                currency: 'usd',
                amountMinor: order.checkoutModel.total.toInt(),
                paymentMethod: paymentMethod,
                user: userData,
                cvc: cvc,
              );

              context
                  .read<PaymentCubit>()
                  .confirmPayment(details, order, cardFlow: CardFlow.savedCard);
            },
            child: const ResponsiveText('Pay'),
          );
        },
      ),
    );
  }
}
