// PaymentRouter (lazy navigation)
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:t_store/features/checkout/presentation/pages/order_review_screen.dart';
import 'package:t_store/features/payment/core/enums/payment_entry_point.dart';
import 'package:t_store/features/payment/presentation/screens/card_selection_screen.dart';
import 'package:t_store/features/payment/presentation/screens/credit_card_screen.dart';
import 'package:t_store/features/payment/presentation/screens/payment_status_screen.dart';
import 'package:t_store/features/payment/presentation/screens/select_payment_screen.dart';
import 'package:t_store/features/payment/routes/payment_flow_args.dart';
import 'package:t_store/features/payment/routes/payment_routes.dart';
import 'package:t_store/features/shop/features/home/presentation/pages/home_page.dart';
import 'package:t_store/features/shop/features/order/presentation/pages/order_page.dart';
import 'package:t_store/features/shop/features/product_details/presentation/pages/product_details_page.dart';

typedef PageFactory = Widget Function(BuildContext, PaymentFlowArgs);

class PaymentRouter {
  static final Map<String, PageFactory> _routes = {
    PaymentRoutes.orderReviewScreen: (context, args) {
      if (args.order != null) {
        return OrderReviewScreen(
          order: args.order,
          removeCartItems: args.removeCartItems,
        );
      }
      if (args.items != null) {
        return OrderReviewScreen(
          items: args.items!,
          removeCartItems: args.removeCartItems,
        );
      }
      return const HomePage();
    },
    PaymentRoutes.selectPayment: (context, args) =>
        SelectPaymentScreen(order: args.order),
    PaymentRoutes.creditCardScreen: (context, args) =>
        CreditCardScreen(entryPoint: args.entryPoint),
    PaymentRoutes.paymentStatusScreen: (context, args) =>
        const PaymentStatusScreen(),
    PaymentRoutes.cardSelectionScreen: (context, args) =>
        const CardSelectionScreen(),
  };

  static Route<dynamic> onGenerateRoute(
    RouteSettings settings,
    PaymentEntryPoint entryPoint,
    PaymentFlowArgs args,
  ) {
    final pageFactory = _routes[settings.name];

    if (pageFactory != null) {
      return _systemNavigation(
        // ignore: no_wildcard_variable_uses
        (_) => pageFactory(_, args),
        settings: settings,
      );
    }
    return _fallbackRoute(entryPoint, args);
  }

  static Route<dynamic> _systemNavigation(
    WidgetBuilder pageBuilder, {
    RouteSettings? settings,
  }) {
    final isIOS = defaultTargetPlatform == TargetPlatform.iOS;
    return isIOS
        ? CupertinoPageRoute(builder: pageBuilder, settings: settings)
        : MaterialPageRoute(builder: pageBuilder, settings: settings);
  }

  static MaterialPageRoute _fallbackRoute(
    PaymentEntryPoint entryPoint,
    PaymentFlowArgs args,
  ) {
    switch (entryPoint) {
      case PaymentEntryPoint.orderPage:
        return MaterialPageRoute(builder: (_) => const OrderPage());
      case PaymentEntryPoint.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case PaymentEntryPoint.productDetailsPage:
        return MaterialPageRoute(
            builder: (_) => ProductDetailsPage(product: args.product!));
    }
  }
}
