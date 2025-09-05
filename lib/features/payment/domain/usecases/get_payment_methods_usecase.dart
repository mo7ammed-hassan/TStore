import 'package:t_store/features/payment/domain/entities/payment_method_entity.dart';
import 'package:t_store/features/payment/domain/repositories/payment_repository.dart';

class GetPaymentMethodsUsecase {
  final PaymentRepository paymentRepository;

  GetPaymentMethodsUsecase(this.paymentRepository);

  Future<List<PaymentMethodEntity>> call() {
    return paymentRepository.getAvailableMethods();
  }
}
