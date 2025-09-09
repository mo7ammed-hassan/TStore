import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:t_store/core/hive_boxes/open_boxes.dart';

abstract class WishlistLocalSources {
  bool isProductInWishlist(String productId, {required String userId});
  Future<String> toggleProductInWishlist(String productId,
      {required String userId});
  Future<void> clearWishlist({required String userId});
  Future<Either<String, List<String>>> fetchWishlist({required String userId});
}

class WishlistLocalSourcesImpl implements WishlistLocalSources {
  @override
  Future<String> toggleProductInWishlist(String productId,
      {required String userId}) async {
    final wishlistBox = Hive.box('wishlist_$userId');
    if (wishlistBox.containsKey(productId)) {
      await wishlistBox.delete(productId);
      return 'Removed from wishlist';
    } else {
      await wishlistBox.put(productId, DateTime.now().toString());
      return 'Added to wishlist';
    }
  }

  @override
  Future<Either<String, List<String>>> fetchWishlist(
      {required String userId}) async {
    // Get Box
    final wishlistBox = await OpenBoxes().openUserWishlistBox(userID: userId);
    try {
      var wishlistIds = wishlistBox.keys.cast<String>().toList();
      if (wishlistIds.isEmpty) return const Right([]);
      return Right(wishlistIds);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<void> clearWishlist({required String userId}) async {
    final wishlistBox = await OpenBoxes().openUserWishlistBox(userID: userId);
    await wishlistBox.clear();
  }

  @override
  bool isProductInWishlist(String productId, {required String userId}) {
    final wishlistBox = Hive.box('wishlist_$userId');
    return wishlistBox.containsKey(productId);
  }
}
