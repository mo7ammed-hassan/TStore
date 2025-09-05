import 'package:t_store/features/payment/data/models/payment_result_model.dart';
import 'package:t_store/features/payment/domain/entities/payment_result_entity.dart';

extension PaymentResultModelX on PaymentResultModel {
  PaymentResultEntity toEntity() {
    return PaymentResultEntity(
      success: success ?? false,             
      clientSecret: clientSecret,           
      transactionId: transactionId,          
      message: message ?? '',                 
    );
  }
}
