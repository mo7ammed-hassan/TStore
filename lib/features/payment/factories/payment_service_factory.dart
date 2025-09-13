import 'package:t_store/core/config/service_locator.dart';
import 'package:t_store/features/payment/core/enums/payment_method.dart';
import 'package:t_store/features/payment/data/datasources/i_payment_service_strategy.dart';

/// Simple Factory Pattern ///
class PaymentServiceFactory {
  static IPaymentServiceStrategy create(PaymentMethods method,
      {CardFlow cardFlow = CardFlow.newCard}) {
    switch (method) {
      case PaymentMethods.stripe:
        return createStripeWithFlow(cardFlow);
      case PaymentMethods.payPal:
        return createPayPalWithFlow(cardFlow);
      case PaymentMethods.vodafone:
        return getIt<IPaymentServiceStrategy>(instanceName: 'vodafone');
      case PaymentMethods.fawry:
        return getIt<IPaymentServiceStrategy>(instanceName: 'fawry');
      case PaymentMethods.cashOnDelivery:
        return getIt<IPaymentServiceStrategy>(instanceName: 'cash');
    }
  }

  static IPaymentServiceStrategy createStripeWithFlow(CardFlow cardFlow) {
    switch (cardFlow) {
      case CardFlow.newCard:
        return getIt<IPaymentServiceStrategy>(instanceName: 'stripeNewCard');
      case CardFlow.savedCard:
        return getIt<IPaymentServiceStrategy>(instanceName: 'stripeSavedCard');
    }
  }

  static IPaymentServiceStrategy createPayPalWithFlow(CardFlow cardFlow) {
    switch (cardFlow) {
      case CardFlow.newCard:
        return getIt<IPaymentServiceStrategy>(instanceName: 'payPalNewCard');
      case CardFlow.savedCard:
        return getIt<IPaymentServiceStrategy>(instanceName: 'payPalSavedCard');
    }
  }
}
