class OrderSummaryModel {
  final double subtotal;
  final double discount;
  final double shipping;
  final double total;

  const OrderSummaryModel({
    required this.subtotal,
    required this.discount,
    required this.shipping,
    required this.total,
  });
}
