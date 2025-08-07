import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/errors/failures.dart';
import 'package:t_store/features/shop/features/cart/data/mapper/cart_item_mapper.dart';
import 'package:t_store/features/shop/features/cart/data/models/cart_item_model.dart';
import 'package:t_store/features/shop/features/cart/data/source/cart_local_storage_services.dart';
import 'package:t_store/features/shop/features/cart/data/source/cart_mangment_service.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/shop/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl extends CartRepository {
  final CartManagementService cartManagementService;
  final CartLocalStorageServices cartLocalStorageServices;

  CartRepositoryImpl(this.cartManagementService, this.cartLocalStorageServices);

  @override
  Future<Either<Failure, List<CartItemEntity>>> fetchCartItems() async {
    try {
      final List<CartItemModel> items =
          await cartLocalStorageServices.fetchCartItems();
      final cartItems = items.map((e) => e.toEntity()).toList();

      return Right(cartItems);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addItemToCart(
      {required CartItemEntity item, int quantity = 1}) async {
    try {
      await cartManagementService.addItemToCart(cartItem: item.toModel());

      return Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeItemFromCart(
      {required CartItemEntity item}) async {
    try {
      await cartManagementService.removeItemFromCart(
          cartItemId: item.product.variation.id);

      return Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> changeItemQuantity(
      {required String itemId, required int quantity}) async {
    try {
      await cartManagementService.changeItemQuantity(
          itemId: itemId, quantity: quantity);

      return Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
