class OrderSummaryEntity {
  final double subtotal;
  final double discount;
  final double shipping;
  final double total;

  const OrderSummaryEntity({
    required this.subtotal,
    required this.discount,
    required this.shipping,
    required this.total,
  });
}
