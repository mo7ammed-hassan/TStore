class OrderSummaryModel {
  final double subtotal;
  final double discount;
  final double shipping;
  final double total;
  final String? transactionId;

  const OrderSummaryModel({
    required this.subtotal,
    required this.discount,
    required this.shipping,
    required this.total,
    this.transactionId,
  });

  OrderSummaryModel copyWith({
    String? transactionId,
  }) {
    return OrderSummaryModel(
      subtotal: subtotal,
      discount: discount,
      shipping: shipping,
      total: total,
      transactionId: transactionId ?? this.transactionId,
    );
  }
}
