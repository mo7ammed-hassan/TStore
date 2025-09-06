import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/config/service_locator.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_state.dart';
import 'package:t_store/features/payment/presentation/screens/credit_card_screen.dart';
import 'package:t_store/features/payment/presentation/widgets/confirm_payment_button.dart';
import 'package:t_store/features/payment/presentation/widgets/payment_card.dart';
import 'package:t_store/features/payment/presentation/widgets/payment_summary.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/navigation.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/utils/responsive/widgets/responsive_padding.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class SelectPaymentScreen extends StatelessWidget {
  const SelectPaymentScreen({super.key, required this.order});
  final OrderEntity? order;

  @override
  Widget build(BuildContext context) {
    final orderSummary = order?.checkoutModel.orderSummary;
    return BlocProvider(
      create: (_) => getIt<PaymentCubit>()..fetchPaymentMethods(),
      child: Scaffold(
        appBar: const TAppBar(
          showBackArrow: true,
          title: TTexts.paymentDetails,
        ),
        body: BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            if (state.action == PaymentAction.fetch &&
                state.status == PaymentStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == PaymentStatus.failure &&
                state.action == PaymentAction.fetch) {
              return Center(child: ResponsiveText('Failed: ${state.error}'));
            }

            if (state.status == PaymentStatus.success &&
                (state.action == PaymentAction.fetch ||
                    state.action == PaymentAction.selectMethod)) {
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
                          selected: state.selectedMethod?.id == method.id,
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
                    enabled: state.selectedMethod != null &&
                        !(state.status == PaymentStatus.loading &&
                            state.action == PaymentAction.processPayment),
                    onPressed: () {
                      context.pushPage(
                        BlocProvider.value(
                          value: context.read<PaymentCubit>(),
                          child: CreditCardScreen(order: order),
                        ),
                      );

                      //context.read<OrderCubit>().changeOrderStaus(order!.orderId);
                    },
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
