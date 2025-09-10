import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/payment/data/models/payment_use_data.dart';
import 'package:t_store/features/payment/domain/entities/payment_details.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_state.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';

class PayButton extends StatelessWidget {
  const PayButton({super.key, required this.order});
  final OrderEntity order;

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
              final shippingAddress = Address(
                city: order.shippingAddress?.city,
                country: '',
                line1: order.shippingAddress?.street,
                line2: '',
                postalCode: order.shippingAddress?.postalCode,
                state: order.shippingAddress?.state,
              );

              final userData = PaymentUserDataModel(
                name: user?.fullName,
                email: user?.userEmail,
                phone: user?.userPhone,
                address: shippingAddress,
              );
              final details = PaymentDetails(
                orderId: order.orderId,
                currency: 'usd',
                amountMinor: order.checkoutModel.total.toInt(),
                //cardDetails: cardDetails,
                user: userData,
              );

              context.read<PaymentCubit>().confirmPayment(details, order);
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
