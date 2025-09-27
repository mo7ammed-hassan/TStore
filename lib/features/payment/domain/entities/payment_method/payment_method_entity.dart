abstract class PaymentMethodEntity<T> {
  final String id;
  final String? email;
  final String? phone;
  final String? type; // card, apple_pay, google_pay, etc.
  final bool? defaultMethod;

  PaymentMethodEntity({
    required this.id,
    this.email,
    this.phone,
    this.type,
    this.defaultMethod,
  });

  String get cardType;

  T get method;

  T copyWith({required bool defaultMethod});
}
