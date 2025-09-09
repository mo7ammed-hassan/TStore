import 'package:dartz/dartz.dart';
import 'package:t_store/core/errors/failures.dart';
import 'package:t_store/core/usecases/use_cases.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/shop/features/cart/domain/repositories/cart_repository.dart';

class FetchCartItemsUseCase
    extends UseCases<Either<Failure, List<CartItemEntity>>, dynamic> {
  final CartRepository _cartRepository;
  FetchCartItemsUseCase(this._cartRepository);

  @override
  Future<Either<Failure, List<CartItemEntity>>> call({dynamic params}) async {
    return await _cartRepository.fetchCartItems();
  }
}
