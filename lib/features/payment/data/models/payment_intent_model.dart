class PaymentIntentModel {
  final String? id;
  final double? amount;
  final String? clientSecret;

  PaymentIntentModel({this.id, this.amount, this.clientSecret});

  factory PaymentIntentModel.fromJson(Map<String, dynamic> json) {
    return PaymentIntentModel(
      id: json['id'] as String?,
      amount: (json['amount'] is int)
          ? (json['amount'] as int).toDouble()
          : json['amount'] as double?,
      clientSecret: json['client_secret'] as String?,
    );
  }
}
