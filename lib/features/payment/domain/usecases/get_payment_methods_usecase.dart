import 'package:t_store/features/payment/domain/entities/card_method_entity.dart';
import 'package:t_store/features/payment/domain/repositories/payment_repository.dart';

class GetPaymentMethodsUsecase {
  final PaymentRepository paymentRepository;

  GetPaymentMethodsUsecase(this.paymentRepository);

  Future<List<CardMethodEntity>> call() {
    return paymentRepository.getAvailableMethods();
  }
}
