import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:t_store/features/payment/data/models/payment_method/stripe/stripe_card_model.dart';
import 'package:t_store/features/payment/domain/entities/payment_method/payment_method_entity.dart';

class StripeCardMethodEntity
    extends PaymentMethodEntity<StripeCardMethodEntity> {
  final StripeCardModel? card;
  final String? customer;
  final String? object;
  final BillingDetails? billingDetails;

  StripeCardMethodEntity({
    required super.id,
    super.defaultMethod,
    super.email,
    super.phone,
    super.type,
    required this.card,
    required this.customer,
    required this.object,
    required this.billingDetails,
  });

  @override
  StripeCardMethodEntity get method => StripeCardMethodEntity(
        id: id,
        defaultMethod: defaultMethod,
        card: card,
        type: type,
        customer: customer,
        object: object,
        billingDetails: billingDetails,
      );

  @override
  String get cardType => card?.brand ?? 'Card';

  @override
  StripeCardMethodEntity copyWith({required bool? defaultMethod}) {
    return StripeCardMethodEntity(
      id: id,
      defaultMethod: defaultMethod ?? this.defaultMethod,
      card: card,
      customer: customer,
      object: object,
      billingDetails: billingDetails,
    );
  }
}
