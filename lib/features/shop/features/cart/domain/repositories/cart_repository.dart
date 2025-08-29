import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/errors/failures.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItemEntity>>> fetchCartItems();

  Future<Either<Failure, Unit>> addItemToCart({required CartItemEntity item});

  Future<Either<Failure, Unit>> removeItemFromCart(
      {required CartItemEntity item});

  Future<Either<Failure, Unit>> changeItemQuantity(
      {required String itemId, required int quantity});

  Future<void> clearCart();
}
