//Pattern: DTO (Data Transfer Object).
class CustomerModel {
  final String? id;
  final String? email;
  final String? name;
  final String? phone;
  final Address? address;
  final String? defaultSource;
  final String? defaultPaymentMethod;

  CustomerModel({
    this.id,
    this.email,
    this.name,
    this.phone,
    this.defaultSource,
    this.address,
    this.defaultPaymentMethod,
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

class Address {
  final String country;
  final String city;
  final String line1;

  Address({
    required this.country,
    required this.city,
    required this.line1,
  });
}
