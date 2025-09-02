import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_state.dart';
import 'package:t_store/features/payment/presentation/widgets/confirm_payment_button.dart';
import 'package:t_store/features/payment/presentation/widgets/payment_card.dart';
import 'package:t_store/features/payment/presentation/widgets/payment_summary.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/utils/responsive/widgets/responsive_padding.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.order});
  final OrderEntity? order;

  @override
  Widget build(BuildContext context) {
    final orderSummary = order?.checkoutModel.orderSummary;
    return BlocProvider(
      create: (_) => PaymentCubit()..fetchPaymentMethods(),
      child: Scaffold(
        appBar: const TAppBar(
          showBackArrow: true,
          title: TTexts.paymentDetails,
        ),
        body: BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: context.responsiveInsets.all(16),
                    itemCount: state.methods.length,
                    separatorBuilder: (_, __) => ResponsiveGap.vertical(12.0),
                    itemBuilder: (context, index) {
                      final method = state.methods[index];
                      return PaymentMethodCard(
                        method: method,
                        selected: state.selected?.id == method.id,
                        onTap: () =>
                            context.read<PaymentCubit>().selectMethod(method),
                      );
                    },
                  ),
                ),
                ResponsivePadding.symmetric(
                  horizontal: 16,
                  vertical: 8,
                  child: PaymentSummary(orderSummary: orderSummary),
                ),
                ConfirmPaymentButton(
                  enabled: state.selected != null,
                  onPressed: () {
                    context.read<PaymentCubit>().confirmPayment(context);
                    //context.read<OrderCubit>().changeOrderStaus(order!.orderId);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
