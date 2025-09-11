import 'package:dartz/dartz.dart';
import 'package:t_store/features/shop/features/all_products/data/models/product_model.dart';
import 'package:t_store/features/shop/features/wishlist/data/source/wishlist_firebase_services.dart';
import 'package:t_store/features/shop/features/wishlist/domain/repositories/wishlist_repository.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistFirebaseServices wishlistFirebaseServices;

  WishlistRepositoryImpl(this.wishlistFirebaseServices);
  @override
  Future<void> addProductToWishlist(String productId) async {
    try {
      return await wishlistFirebaseServices.addProductToWishlist(productId);
    } catch (e) {
      throw 'Error adding product to wishlist: $e';
    }
  }

  @override
  Future<void> clearWishlist() async {
    try {
      return await wishlistFirebaseServices.clearWishlist();
    } catch (e) {
      throw 'Error clearing wishlist: $e';
    }
  }

  @override
  Future<Either<dynamic, List<String>>> fetchWishlist() async {
    var returnedData = await wishlistFirebaseServices.fetchWishlist();

    return returnedData.fold(
      (e) {
        return Left(e);
      },
      (data) {
        List<String> products = List.from(data)
            .map((document) => ProductModel.fromJson(document).id)
            .toList();

        return Right(products);
      },
    );
  }

  @override
  Future<bool> isProductInWishlist(String productId) async {
    try {
      return await wishlistFirebaseServices.isProductInWishlist(productId);
    } catch (e) {
      throw 'Error checking if product is in wishlist: $e';
    }
  }

  @override
  Future<void> removeProductFromWishlist(String productId) {
    try {
      return wishlistFirebaseServices.removeProductFromWishlist(productId);
    } catch (e) {
      throw 'Error removing product from wishlist: $e';
    }
  }
}
