class PaymentResultEntity {
  final bool success;
  final String transactionId;
  final String message;

  PaymentResultEntity({
    required this.success,
    required this.transactionId,
    required this.message,
  });
}
