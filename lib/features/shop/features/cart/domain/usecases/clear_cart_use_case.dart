import 'package:t_store/common/core/usecases/use_cases.dart';
import 'package:t_store/features/shop/features/cart/domain/repositories/cart_repository.dart';

class ClearCartUsecase
    extends UseCases<void, dynamic> {
  final CartRepository _cartRepository;
  ClearCartUsecase(this._cartRepository);

  @override
  Future<void> call({dynamic params}) async {
    return await _cartRepository.clearCart();
  }
}
