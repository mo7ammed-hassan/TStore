class CreditCardFormState {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final bool isCvvFocused;
  final bool saveCard;

  CreditCardFormState({
    this.cardNumber = '',
    this.expiryDate = '',
    this.cardHolderName = '',
    this.cvvCode = '',
    this.isCvvFocused = false,
    this.saveCard = false,
  });

  CreditCardFormState copyWith({
    String? cardNumber,
    String? expiryDate,
    String? cardHolderName,
    String? cvvCode,
    bool? isCvvFocused,
    bool? saveCard,
  }) {
    return CreditCardFormState(
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cvvCode: cvvCode ?? this.cvvCode,
      isCvvFocused: isCvvFocused ?? this.isCvvFocused,
      saveCard: saveCard ?? this.saveCard,
    );
  }
}
