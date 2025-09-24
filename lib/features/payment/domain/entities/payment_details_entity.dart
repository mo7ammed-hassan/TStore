import 'package:t_store/features/payment/domain/entities/card_details_entity.dart';
import 'package:t_store/features/payment/domain/entities/payment_method/payment_method_entity.dart';
import 'package:t_store/features/payment/domain/entities/payment_user_data_entity.dart';

class PaymentDetailsEntity {
  final int amountMinor; // amount in minor units (e.g., 10000 = 100.00 EGP)
  final String currency; // e.g., EGP
  final String orderId;
  final Map<String, dynamic>? meta; // optional extra fields per gateway
  final CardDetailsEntity? cardDetails;
  final PaymentUserDataEntity? user;
  final PaymentMethodEntity? paymentMethod;
  final String? cvc;
  final bool saveCard;

  const PaymentDetailsEntity({
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

  PaymentDetailsEntity copyWith({
    CardDetailsEntity? cardDetails,
    PaymentUserDataEntity? user,
    PaymentMethodEntity? paymentMethod,
    String? cvc,
    bool? saveCard,
  }) {
    return PaymentDetailsEntity(
      amountMinor: amountMinor,
      currency: currency,
      orderId: orderId,
      cardDetails: cardDetails ?? this.cardDetails,
      user: user ?? this.user,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      cvc: cvc ?? this.cvc,
      saveCard: saveCard ?? this.saveCard,
    );
  }
}
