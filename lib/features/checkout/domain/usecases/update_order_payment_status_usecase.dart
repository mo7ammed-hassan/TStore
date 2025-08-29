import 'package:t_store/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:t_store/utils/constants/enums.dart';

class UpdateOrderPaymentStatusUsecase {
  final CheckoutRepository _checkoutRepository;

  UpdateOrderPaymentStatusUsecase(this._checkoutRepository);

  Future<void> call(PaymentStatus newStatus, String orderId) async {
    await _checkoutRepository.updateOrderPaymentStatus(
      newStatus: newStatus,
      orderId: orderId,
    );
  }
}
