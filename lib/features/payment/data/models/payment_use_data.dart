import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentUserDataModel {
  final String? customerId;
  final String? name;
  final String? email;
  final String? phone;
  final Address? address;

  PaymentUserDataModel( {this.name, this.email, this.phone, this.address, this.customerId});
}
