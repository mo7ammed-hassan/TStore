import 'package:t_store/features/checkout/domain/entities/checkout_entity.dart';
import 'package:t_store/features/checkout/domain/entities/order_entity.dart';
import 'package:t_store/features/checkout/domain/repositories/checkout_repository.dart';

class CreateOrderDraftUsecase {
  final CheckoutRepository _checkoutRepository;

  CreateOrderDraftUsecase(this._checkoutRepository);

  Future<OrderEntity> call(CheckoutEntity checkoutData) async {
    return await _checkoutRepository.createOrderDraft(
      checkoutData: checkoutData,
    );
  }
}
