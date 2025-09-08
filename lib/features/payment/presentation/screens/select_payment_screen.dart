import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/config/service_locator.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/payment/core/enums/payment_entry_point.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_state.dart';
import 'package:t_store/features/payment/presentation/widgets/confirm_payment_button.dart';
import 'package:t_store/features/payment/presentation/widgets/payment_card.dart';
import 'package:t_store/features/payment/presentation/widgets/payment_summary.dart';
import 'package:t_store/features/payment/routes/payment_routes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/utils/responsive/widgets/responsive_padding.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class SelectPaymentScreen extends StatelessWidget {
  const SelectPaymentScreen({
    super.key,
    required this.order,
    this.entryPoint,
  });
  final OrderEntity? order;
  final PaymentEntryPoint? entryPoint;

  @override
  Widget build(BuildContext context) {
    final orderSummary = order?.checkoutModel.orderSummary;

    return BlocProvider(
      create: (_) => getIt<PaymentCubit>()..fetchPaymentMethods(),
      child: Scaffold(
        appBar: const TAppBar(
          showBackArrow: true,
          nestedNavigator: true,
          title: TTexts.paymentDetails,
        ),
        body: BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            if (state.action == PaymentAction.fetch &&
                state.status == PaymentStateStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == PaymentStateStatus.failure &&
                state.action == PaymentAction.fetch) {
              return Center(child: ResponsiveText('Failed: ${state.error}'));
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
                      !(state.status == PaymentStateStatus.loading &&
                          state.action == PaymentAction.processPayment),
                  onPressed: () {
                    final paymentCubit = context.read<PaymentCubit>();
                    Navigator.pushNamed(
                      context,
                      PaymentRoutes.creditCardScreen,
                      arguments: {
                        'order': order,
                        'paymentCubit': paymentCubit,
                      },
                    );
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
