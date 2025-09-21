class CardDetailsEntity {
  final String cardNumber;
  final int expMonth;
  final int expYear;
  final String cvcCode;

  CardDetailsEntity({
    required this.cardNumber,
    required this.expMonth,
    required this.expYear,
    required this.cvcCode,
  });
}
