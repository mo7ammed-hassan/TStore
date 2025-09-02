class PaymentMethodEntity {
  final String id;
  final String name;
  final String logoUrl;
  final bool isOnline;

  PaymentMethodEntity({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.isOnline,
  });
}
