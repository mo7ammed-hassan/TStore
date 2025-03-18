import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/errors/failures.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/cart/data/models/cart_item_model.dart';
import 'package:t_store/features/shop/features/cart/data/source/cart_local_storage_services.dart';
import 'package:t_store/features/shop/features/cart/data/source/cart_managment_service.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/shop/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl extends CartRepository {
  final CartManagementService cartManagementService;
  final CartLocalStorageServices cartLocalStorageServices;

  CartRepositoryImpl(this.cartManagementService, this.cartLocalStorageServices);

  @override
  Future<Either<Failure, void>> addProductToCart({
    required ProductEntity product,
    required int quantity,
  }) async {
    try {
      await cartManagementService.addProductToCart(
          product: product, quantity: quantity);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addSingleItemToCart({
    required CartItemModel cartItem,
  }) async {
    try {
      await cartManagementService.addSingleItemToCart(cartItem: cartItem);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeAllItemsFromCart() async {
    try {
      await cartManagementService.removeAllItemsFromCart();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeSingleItemFromCart({
    required CartItemModel cartItem,
  }) async {
    try {
      await cartManagementService.removeSingleItemFromCart(cartItem: cartItem);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, List<CartItemEntity>>> fetchCartItems() async {
    try {
      var cartModels = cartLocalStorageServices.fetchCartItems();
      List<CartItemEntity> cartItems =
          cartModels.map((cartModel) => cartModel.toEntity()).toList();
      return Right(cartItems);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  int getItemQuantityWithVariationId(
      {required String productId, required String selectedVariationId}) {
    try {
      var quantity = cartLocalStorageServices.getItemQuantityWithVariationId(
          productId: productId, selectedVariationId: selectedVariationId);

      return quantity;
    } catch (e) {
      rethrow;
    }
  }
}
