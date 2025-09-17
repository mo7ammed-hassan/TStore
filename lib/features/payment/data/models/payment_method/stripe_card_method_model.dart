import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:t_store/features/payment/data/models/payment_method/payment_method_model.dart';
import 'package:t_store/features/payment/data/models/payment_method/stripe_card_model.dart';
import 'package:t_store/features/payment/domain/entities/stripe_card_method_entity.dart';

class StripeCardMethodModel extends PaymentMethodModel<StripeCardMethodEntity> {
  final StripeCardModel? card;
  final String? customer;
  final String? object;
  final BillingDetails? billingDetails;

  StripeCardMethodModel({
    required super.id,
    this.customer,
    this.object,
    this.billingDetails,
    this.card,
  });

  factory StripeCardMethodModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return StripeCardMethodModel(
      id: json['id'],
      object: json['object'],
      card: StripeCardModel.fromJson(json['card']),
      customer: json['customer'],
      billingDetails: BillingDetails.fromJson(json['billing_details']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }

  @override
  StripeCardMethodEntity toEntity() {
    return StripeCardMethodEntity(
      id: id,
      card: card,
      customer: customer,
      object: object,
      billingDetails: billingDetails,
    );
  }
}
