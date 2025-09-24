import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/core.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/checkout/domain/entities/order_summary_entity.dart';
import 'package:t_store/features/payment/payment.dart';
import 'package:t_store/features/shop/features/order/presentation/cuits/order_cubit.dart';
import 'package:t_store/features/shop/features/order/presentation/pages/order_page.dart';

class PaymentFlowScreen extends StatelessWidget {
  const PaymentFlowScreen({
    super.key,
    required this.entryPoint,
    required this.args,
  });

  final PaymentEntryPoint entryPoint;
  final PaymentFlowArgs args;

  @override
  Widget build(BuildContext context) {
    final order = args.order;
    return BlocProvider(
      create: (context) => getIt<PaymentCubit>()..fetchServiceMethods(),
      child: _handlePaymentListener(order),
    );
  }

  BlocListener<PaymentCubit, PaymentState> _handlePaymentListener(
      OrderEntity? order) {
    return BlocListener<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state.status == PaymentStateStatus.loading &&
            state.action == PaymentAction.processPayment) {
          LoadingDialog.show(context, message: 'Processing Payment');
        }
        if (state.action == PaymentAction.processPayment &&
            state.status == PaymentStateStatus.success) {
          if (entryPoint == PaymentEntryPoint.orderPage) {
            LoadingDialog.hide(context);
            context.read<OrderCubit>().changeOrderStaus(order!.orderId);
          }

          _onPaymentSuccess(
            context,
            state.paymentResult?.orderSummary,
            state.paymentResult,
          );
        } else if (state.action == PaymentAction.processPayment &&
            state.status == PaymentStateStatus.failure) {
          LoadingDialog.hide(context);
          _onPaymentErro(context);
        }
      },
      child: PopScope(
        canPop: false,
        child: Navigator(
          initialRoute: PaymentRoutes.orderReviewScreen,
          onGenerateRoute: (settings) =>
              PaymentRouter.onGenerateRoute(settings, entryPoint, args),
        ),
      ),
    );
  }

  void _onPaymentSuccess(
    BuildContext context,
    OrderSummaryEntity? orderSummary,
    PaymentResultEntity? paymentResult,
  ) {
    Navigator.of(context, rootNavigator: false).pushReplacement(
      MaterialPageRoute(
        builder: (context) => PaymentStatusScreen(
          paymentResult: paymentResult,
          onTap: () {
            if (entryPoint == PaymentEntryPoint.orderPage) {
              Navigator.of(context, rootNavigator: true).pop();
            } else {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context, rootNavigator: true).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const OrderPage(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _onPaymentErro(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentStatusScreen(
          title: 'Payment Failed',
          subTitle: 'Sorry your transaction could not processed',
          imagePath: PaymentImages.paymentFailed,
          paymentSuccess: false,
          buttonTitle: 'Back',
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
