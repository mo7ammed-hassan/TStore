class PaymentResultEntity {
  final bool success;
  final String? clientSecret; // for stripe
  final String? transactionId; // for Vodafone / DVD
  final String message;

  PaymentResultEntity({
    required this.success,
    this.clientSecret,
    this.transactionId,
    required this.message,
  });
}
