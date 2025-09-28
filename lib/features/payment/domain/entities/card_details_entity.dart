import 'package:t_store/features/payment/domain/entities/payment_user_data_entity.dart';

class CardDetailsEntity {
  final String? cardNumber;
  final int? expMonth;
  final int? expYear;
  final String? cvcCode;
  final PaymentUserDataEntity? userData;

  CardDetailsEntity({
    this.cardNumber,
    this.expMonth,
    this.expYear,
    this.cvcCode,
    this.userData,
  });
}
