abstract class PaymentMethodEntity<T> {
  final String id;
  final String? email;
  final String? phone;
  final String? type; // card, apple_pay, google_pay, etc.

  PaymentMethodEntity({required this.id, this.email, this.phone, this.type});

  String get cardType;

  T get method;
}
