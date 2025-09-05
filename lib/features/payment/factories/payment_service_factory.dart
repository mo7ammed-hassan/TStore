import 'package:t_store/config/service_locator.dart';
import 'package:t_store/features/payment/core/enums/payment_method.dart';
import 'package:t_store/features/payment/data/datasources/i_payment_service.dart';

class PaymentServiceFactory {
  static IPaymentService create(PaymentMethods method) {
    switch (method) {
      case PaymentMethods.stripe:
        return getIt<IPaymentService>(instanceName: 'stripe');
      case PaymentMethods.vodafone:
        return getIt<IPaymentService>(instanceName: 'vodafone');
      case PaymentMethods.fawry:
        return getIt<IPaymentService>(instanceName: 'fawry');
      case PaymentMethods.payPal:
        return getIt<IPaymentService>(instanceName: 'payPal');
      case PaymentMethods.cashOnDelivery:
        return getIt<IPaymentService>(instanceName: 'cash');
    }
  }
}
