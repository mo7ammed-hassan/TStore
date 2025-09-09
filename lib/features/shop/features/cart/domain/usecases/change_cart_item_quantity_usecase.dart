import 'package:dartz/dartz.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/core/usecases/use_cases.dart';
import 'package:t_store/features/shop/features/cart/domain/repositories/cart_repository.dart';

class ChangeCartItemQuantityUsecase
    extends UseCases<Either<Failure, Unit>, (String itemId, int quantity)> {
  final CartRepository _cartRepository;

  ChangeCartItemQuantityUsecase(this._cartRepository);

  @override
  Future<Either<Failure, Unit>> call(
      {(String itemId, int quantity)? params}) async {
    final (itemId, quantity) = params!;

    return _cartRepository.changeItemQuantity(
        itemId: itemId, quantity: quantity);
  }
}
