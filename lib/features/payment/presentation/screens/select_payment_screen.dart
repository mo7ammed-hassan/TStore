import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/t_appbar.dart';
import 'package:t_store/core/core.dart';
import 'package:t_store/features/checkout/data/models/order_summary_model.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';
import 'package:t_store/features/payment/payment.dart';

class SelectPaymentScreen extends StatelessWidget {
  const SelectPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)?.settings.arguments as OrderEntity?;
    final orderSummary = order?.checkoutModel.orderSummary;
    final stripeCustomerId =
        context.read<UserCubit>().state.user?.stripeCustomerId;
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        nestedNavigator: true,
        title: TTexts.paymentDetails,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildPaymentMethodsList(context),
          ),
          _buildOrderSummary(orderSummary),
          _buildContinueButton(context, order, stripeCustomerId),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodsList(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        if (state.action == PaymentAction.fetch &&
            state.status == PaymentStateStatus.loading) {
          return _buildLoadingIndicator();
        }

        if (state.status == PaymentStateStatus.failure &&
            state.action == PaymentAction.fetch) {
          return _buildErrorWidget(state.error);
        }

        return ListView.separated(
          padding: context.responsiveInsets.all(16),
          itemCount: state.methods.length,
          separatorBuilder: (_, __) => ResponsiveGap.vertical(12.0),
          itemBuilder: (context, index) {
            final method = state.methods[index];
            return PaymentMethodCard(
              method: method,
              selected: state.selectedMethod?.id == method.id,
              onTap: () => context.read<PaymentCubit>().selectMethod(method),
            );
          },
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildErrorWidget(String? error) {
    return Center(
      child: ResponsiveText('Failed: ${error ?? "Unknown error"}'),
    );
  }

  Widget _buildOrderSummary(OrderSummaryModel? orderSummary) {
    return ResponsivePadding.symmetric(
      horizontal: 16,
      vertical: 8,
      child: PaymentSummary(orderSummary: orderSummary),
    );
  }

  Widget _buildContinueButton(
      BuildContext context, OrderEntity? order, String? stripeCustomerId) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        final isButtonEnabled = state.selectedMethod != null &&
            !(state.status == PaymentStateStatus.loading &&
                state.action == PaymentAction.processPayment);

        return ContinueButton(
          enabled: isButtonEnabled,
          onPressed: () =>
              _handleContinueButtonPress(context, order, stripeCustomerId),
        );
      },
    );
  }

  void _handleContinueButtonPress(
      BuildContext context, OrderEntity? order, String? stripeCustomerId) {
    final paymentCubit = context.read<PaymentCubit>();
    final method = paymentCubit.state.defaultMethod;

    if (method != null) {
      Navigator.pushNamed(
        context,
        PaymentRoutes.confimPaymentScreen,
        arguments: {'order': order, 'method': method},
      );
    } else {
      Navigator.pushNamed(
        context,
        PaymentRoutes.addCardScreen,
        arguments: order,
      );
    }
  }
}
