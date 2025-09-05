import 'package:t_store/features/payment/data/models/credit_card_details_model.dart';
import 'package:t_store/features/payment/data/models/payment_use_data.dart';

class PaymentDetails {
  final int amountMinor; // amount in minor units (e.g., 10000 = 100.00 EGP)
  final String currency; // e.g., EGP
  final String orderId;
  final Map<String, dynamic>? meta; // optional extra fields per gateway
  final CreditCardDetailsModel? cardDetails;
  final PaymentUserDataModel? user;

  const PaymentDetails({
    required this.amountMinor,
    required this.currency,
    required this.orderId,
    this.meta,
    this.cardDetails,
    this.user,
  });

  PaymentDetails copyWith({
    CreditCardDetailsModel? cardDetails,
    PaymentUserDataModel? user,
  }) {
    return PaymentDetails(
      amountMinor: amountMinor,
      currency: currency,
      orderId: orderId,
      cardDetails: cardDetails ?? this.cardDetails,
      user: user ?? this.user,
    );
  }
}
