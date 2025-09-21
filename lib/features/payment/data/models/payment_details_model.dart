import 'package:t_store/features/payment/data/models/card_details_model.dart';
import 'package:t_store/features/payment/data/models/payment_user_data.dart';

class PaymentDetailsModel {
  final int amountMinor; // amount in minor units (e.g., 10000 = 100.00 EGP)
  final String currency; // e.g., EGP
  final String orderId;
  final Map<String, dynamic>? meta; // optional extra fields per gateway
  final CardDetailsModel? cardDetails;
  final PaymentUserDataModel? user;
  final String? paymentMethodId;
  final String? cvc;

  const PaymentDetailsModel({
    required this.amountMinor,
    required this.currency,
    required this.orderId,
    this.meta,
    this.cardDetails,
    this.user,
    this.paymentMethodId,
    this.cvc,
  });
}
