import 'package:t_store/features/payment/core/enums/payment_method.dart';
import 'package:t_store/features/payment/data/models/payment_method_model.dart';
import 'package:t_store/core/utils/constants/images_strings.dart';

class PaymentMethodsList {
  static final methods = [
    PaymentMethodModel(
      id: 'stripe_1445',
      name: 'Credit Card',
      logoUrl: TImages.creditCard,
      method: PaymentMethods.stripe,
      isOnline: true,
    ),
    PaymentMethodModel(
      id: 'payPal_7845',
      name: 'PayPal',
      logoUrl: TImages.paypal,
      method: PaymentMethods.payPal,
      isOnline: true,
    ),
    PaymentMethodModel(
      id: 'cash_024',
      name: 'Cash on Delivery',
      logoUrl: TImages.cod,
      method: PaymentMethods.cashOnDelivery,
      isOnline: true,
    ),
  ];
}
