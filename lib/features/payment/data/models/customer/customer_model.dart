//Pattern: DTO (Data Transfer Object).
import 'package:flutter_stripe/flutter_stripe.dart';

class CustomerModel {
  final String? id;
  final String? email;
  final String? name;
  final String? phone;
  final String? defaultSource;
  final String? defaultPaymentMethod;
  final Address? address;

  CustomerModel({
    this.id,
    this.email,
    this.name,
    this.phone,
    this.defaultSource,
    this.defaultPaymentMethod,
    this.address,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      defaultSource: json['default_source'],
      defaultPaymentMethod: json['invoice_settings']?['default_payment_method'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'default_source': defaultSource,
      'default_payment_method': defaultPaymentMethod,
    };
  }
}
