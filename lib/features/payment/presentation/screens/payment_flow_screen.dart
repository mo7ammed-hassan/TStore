import 'package:flutter/material.dart';
import 'package:t_store/features/payment/core/enums/payment_entry_point.dart';
import 'package:t_store/features/payment/routes/payment_flow_args.dart';
import 'package:t_store/features/payment/routes/payment_router.dart';
import 'package:t_store/features/payment/routes/payment_routes.dart';

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
    return PopScope(
      canPop: false,
      child: Navigator(
        initialRoute: PaymentRoutes.orderReviewScreen,
        onGenerateRoute: (settings) =>
            PaymentRouter.onGenerateRoute(settings, entryPoint, args),
      ),
    );
  }
}
