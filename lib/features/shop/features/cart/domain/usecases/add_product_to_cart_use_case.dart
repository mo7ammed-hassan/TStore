import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/errors/failures.dart';
import 'package:t_store/common/core/usecases/use_cases.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/cart/domain/repositories/cart_repository.dart';

class AddProductToCartUseCase
    extends UseCases<Either<Failure, void>, ProductEntity> {
  final CartRepository _cartRepository;

  AddProductToCartUseCase(this._cartRepository);

  @override
  Future<Either<Failure, void>> call(
      {ProductEntity? params, int? quantity}) async {
    return await _cartRepository.addProductToCart(
        product: params!, quantity: quantity!);
  }
}
