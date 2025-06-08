import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/errors/failures.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/cart/data/models/cart_item_model.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';

abstract class CartRepository {
  Future<Either<ServerFailure, List<CartItemEntity>>> fetchCartItems();
  Future<Either<Failure, void>> addProductToCart(
      {required ProductEntity product, required int quantity});
  Future<Either<Failure, void>> addSingleItemToCart(
      {required CartItemModel cartItem});
  Future<Either<Failure, void>> removeSingleItemFromCart(
      {required CartItemModel cartItem});
  Future<Either<Failure, void>> removeAllItemsFromCart();
  int getItemQuantityWithVariationId(
      {required String productId, required String selectedVariationId});
}
