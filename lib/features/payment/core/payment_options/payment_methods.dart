import 'package:t_store/features/payment/core/enums/payment_method.dart';
import 'package:t_store/features/payment/data/models/card_mthod_model.dart';
import 'package:t_store/core/utils/constants/images_strings.dart';

class PaymentMethodsList {
  static final methods = [
    CardMethodModel(
      id: 'stripe_1445',
      name: 'Credit Card',
      logoUrl: TImages.creditCard,
      method: PaymentMethods.stripe,
      isOnline: true,
    ),
    CardMethodModel(
      id: 'payPal_7845',
      name: 'PayPal',
      logoUrl: TImages.paypal,
      method: PaymentMethods.payPal,
      isOnline: true,
    ),
    CardMethodModel(
      id: 'cash_024',
      name: 'Cash on Delivery',
      logoUrl: TImages.cod,
      method: PaymentMethods.cashOnDelivery,
      isOnline: true,
    ),
  ];
}
