import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:t_store/features/payment/data/models/payment_method/stripe_card_model.dart';
import 'package:t_store/features/payment/domain/entities/payment_method_entity.dart';

class StripeCardMethodEntity
    extends PaymentMethodEntity<StripeCardMethodEntity> {
  final StripeCardModel? card;
  final String? customer;
  final String? object;
  final BillingDetails? billingDetails;

  StripeCardMethodEntity({
    required super.id,
    super.email,
    super.phone,
    required this.card,
    required this.customer,
    required this.object,
    required this.billingDetails,
  });

  @override
  StripeCardMethodEntity get method => StripeCardMethodEntity(
        id: id,
        card: card,
        customer: customer,
        object: object,
        billingDetails: billingDetails,
      );
}
