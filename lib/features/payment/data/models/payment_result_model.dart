class PaymentResultModel {
  final bool? success;
  final String? transactionId;
  final String? clientSecret;
  final String? card;
  final String? message;

  const PaymentResultModel({
    this.success,
    this.clientSecret,
    this.transactionId,
    this.message,
    this.card,
  });
}
