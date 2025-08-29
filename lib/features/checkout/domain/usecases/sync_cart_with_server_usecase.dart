import 'package:t_store/features/checkout/domain/entities/checkout_entity.dart';
import 'package:t_store/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';

class SyncCartWithServerUseCase {
  final CheckoutRepository _checkoutRepository;

  SyncCartWithServerUseCase(this._checkoutRepository);

  Future<CheckoutEntity> call(List<CartItemEntity> itemsPayload) async {
    return await _checkoutRepository.syncCartWithServer(
      itemsPayload: itemsPayload,
    );
  }
}
