import 'package:t_store/features/payment/data/data.dart';

class PaymentDetailsModel {
  final int amountMinor; // amount in minor units (e.g., 10000 = 100.00 EGP)
  final String currency; // e.g., EGP
  final String orderId;
  final Map<String, dynamic>? meta; // optional extra fields per gateway
  final CardDetailsModel? cardDetails;
  final PaymentUserDataModel? user;
  final PaymentMethodModel? paymentMethod;
  final String? cvc;
  final bool saveCard;

  const PaymentDetailsModel({
    required this.amountMinor,
    required this.currency,
    required this.orderId,
    this.meta,
    this.cardDetails,
    this.user,
    this.paymentMethod,
    this.cvc,
    this.saveCard = false,
  });
}
