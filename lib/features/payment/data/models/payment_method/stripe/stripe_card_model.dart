import 'package:flutter_stripe/flutter_stripe.dart';

class StripeCardModel {
  final String? brand;
  final String? country;
  final int? expYear;
  final int? expMonth;
  final String? funding;
  final String? last4;
  final String? preferredNetwork;
  final List<String>? availableNetworks;

  StripeCardModel({
    this.brand,
    this.country,
    this.expYear,
    this.expMonth,
    this.funding,
    this.last4,
    this.preferredNetwork,
    this.availableNetworks,
  });

  factory StripeCardModel.fromJson(Map<String, dynamic> json) {
    return StripeCardModel(
      brand: json['brand'],
      country: json['country'],
      expYear: json['exp_year'],
      expMonth: json['exp_month'],
      funding: json['funding'],
      last4: json['last4'],
      preferredNetwork: json['preferred_network'],
      availableNetworks: (json['available_networks'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brand': brand,
      'country': country,
      'exp_year': expYear,
      'exp_month': expMonth,
      'funding': funding,
      'last4': last4,
      'preferred_network': preferredNetwork,
      'available_networks': availableNetworks,
    };
  }

  static StripeCardModel? fromCard(Card card) {
    return StripeCardModel(
      brand: card.brand,
      country: card.country,
      expYear: card.expYear,
      expMonth: card.expMonth,
      funding: card.funding,
      last4: card.last4,
      preferredNetwork: card.preferredNetwork,
      availableNetworks: card.availableNetworks,
    );
  }
}
