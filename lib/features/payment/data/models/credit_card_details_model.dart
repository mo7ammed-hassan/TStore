class CreditCardDetailsModel {
  final String cardNumber;
  final int expMonth;
  final int expYear;
  final String cvvCode;

  CreditCardDetailsModel({
    required this.cardNumber,
    required this.expMonth,
    required this.expYear,
    required this.cvvCode,
  });
}
