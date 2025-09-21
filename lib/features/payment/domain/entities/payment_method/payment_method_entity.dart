abstract class PaymentMethodEntity<T> {
  final String id;
  final String? email;
  final String? phone;

  PaymentMethodEntity({required this.id, this.email, this.phone});

  T get method;
}
