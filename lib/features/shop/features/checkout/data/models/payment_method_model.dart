class PaymentMethodModel {
  final String name;
  final String image;

  const PaymentMethodModel({
    required this.name,
    required this.image,
  });

  static PaymentMethodModel empty() {
    return const PaymentMethodModel(name: '', image: '');
  }

}
