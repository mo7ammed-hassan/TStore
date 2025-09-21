import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentUserDataEntity {
  final String? customerId;
  final String? name;
  final String? email;
  final String? phone;
  final Address? address;

  PaymentUserDataEntity({
    this.name,
    this.email,
    this.phone,
    this.address,
    this.customerId,
  });
}
