import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/config/service_locator.dart';
import 'package:t_store/features/checkout/data/models/order_summary_model.dart';
import 'package:t_store/features/payment/core/constants/payment_images.dart';
import 'package:t_store/features/payment/core/enums/payment_entry_point.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_state.dart';
import 'package:t_store/features/payment/presentation/screens/payment_status_screen.dart';
import 'package:t_store/features/payment/routes/payment_flow_args.dart';
import 'package:t_store/features/payment/routes/payment_router.dart';
import 'package:t_store/features/payment/routes/payment_routes.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';
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
    final stripeCustomerId =
        context.read<UserCubit>().state.user?.stripeCustomerId;

    return BlocProvider(
      create: (context) => getIt<PaymentCubit>()
        ..fetchPaymentMethods()
        ..getDefaultPaymentMethod(customerId: stripeCustomerId),
      child: BlocListener<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state.action == PaymentAction.processPayment &&
              state.status == PaymentStateStatus.success) {
            if (entryPoint == PaymentEntryPoint.orderPage) {
              context.read<OrderCubit>().changeOrderStaus(order!.orderId);
            }
            final orderSummary = order?.checkoutModel.orderSummary
                .copyWith(transactionId: state.paymentResult?.transactionId);

            _onPaymentSuccess(context, orderSummary);
          } else if (state.action == PaymentAction.processPayment &&
              state.status == PaymentStateStatus.failure) {
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
      ),
    );
  }

  void _onPaymentSuccess(
    BuildContext context,
    OrderSummaryModel? orderSummary,
  ) {
    Navigator.of(context, rootNavigator: false).pushReplacement(
      MaterialPageRoute(
        builder: (context) => PaymentStatusScreen(
          orderSummary: orderSummary,
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
