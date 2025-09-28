import 'package:t_store/features/payment/domain/entities/card_details_entity.dart';
import 'package:t_store/features/payment/domain/entities/payment_method/payment_method_entity.dart';

class PaymentDetailsEntity {
  final int amountMinor; // amount in minor units (e.g., 10000 = 100.00 EGP)
  final String currency; // e.g., EGP
  final String orderId;
  final Map<String, dynamic>? meta; // optional extra fields per gateway
  final CardDetailsEntity? cardDetails;
  final PaymentMethodEntity? paymentMethod;
  final bool saveCard;

  const PaymentDetailsEntity({
    required this.amountMinor,
    required this.currency,
    required this.orderId,
    this.meta,
    this.cardDetails,
    this.paymentMethod,
    this.saveCard = false,
  });

  PaymentDetailsEntity copyWith({
    CardDetailsEntity? cardDetails,
    PaymentMethodEntity? paymentMethod,
    bool? saveCard,
  }) {
    return PaymentDetailsEntity(
      amountMinor: amountMinor,
      currency: currency,
      orderId: orderId,
      cardDetails: cardDetails ?? this.cardDetails,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      saveCard: saveCard ?? this.saveCard,
    );
  }
}
