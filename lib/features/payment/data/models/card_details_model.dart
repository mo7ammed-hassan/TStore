import 'package:t_store/features/payment/data/models/payment_user_data.dart';

class CardDetailsModel {
  final String? cardNumber;
  final int? expMonth;
  final int? expYear;
  final String cvcCode;
  final PaymentUserDataModel? userData;

  CardDetailsModel({
    this.cardNumber,
    this.expMonth,
    this.expYear,
    required this.cvcCode,
    this.userData,
  });
}
