// Unified Domain Model
// Pattern: Enterprise Business Rules.
class CustomerEntity {
  final String? id; // Stripe Customer ID
  final String? email;
  final String? name;
  final String? phone;
  final String? defaultSource;
  final String? defaultPaymentMethod; // payment method id

  CustomerEntity({
    this.id,
    this.email,
    this.name,
    this.phone,
    this.defaultSource,
    this.defaultPaymentMethod,
  });
}
