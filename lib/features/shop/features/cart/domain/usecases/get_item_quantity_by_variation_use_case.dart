import 'package:t_store/features/shop/features/cart/domain/repositories/cart_repository.dart';

class GetItemQuantityByVariationUseCase {
  final CartRepository _cartRepository;

  GetItemQuantityByVariationUseCase(this._cartRepository);

  int call({required String productId, required String variationId}) {
    return _cartRepository.getItemQuantityWithVariationId(
        productId: productId, selectedVariationId: variationId);
  }
}
