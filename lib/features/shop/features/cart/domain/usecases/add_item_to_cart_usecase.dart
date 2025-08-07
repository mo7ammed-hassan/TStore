import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/usecases/use_cases.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/shop/features/cart/domain/repositories/cart_repository.dart';

class AddItemToCartUsecase extends UseCases<Either, CartItemEntity> {
  final CartRepository _cartRepository;
  AddItemToCartUsecase(this._cartRepository);

  @override
  Future<Either> call({CartItemEntity? params}) async {
    return _cartRepository.addItemToCart(item: params!);
  }
}
