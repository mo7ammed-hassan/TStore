import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/use_cases.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/shop/features/cart/domain/repositories/cart_repository.dart';

class RemoveItemFromCartUsecase extends UseCases<Either, CartItemEntity> {
  final CartRepository _cartRepository;
  RemoveItemFromCartUsecase(this._cartRepository);

  @override
  Future<Either> call({CartItemEntity? params}) async {
    return _cartRepository.removeItemFromCart(item: params!);
  }
}
