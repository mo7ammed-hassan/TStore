import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/all_products/domain/usecases/get_product_usecase.dart';
import 'package:t_store/features/shop/features/wishlist/data/source/wislist_local_sources.dart';
import 'package:t_store/features/shop/features/wishlist/presentation/pages/cubits/wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit(this.productsUseCase) : super(WishlistInitial());
  final GetProductsUseCase productsUseCase;
  final _localSources = WishlistLocalSourcesImpl();

  final _userID = FirebaseAuth.instance.currentUser!.uid;

  Future<void> fetchWishlist() async {
    final wishlist = await _localSources.fetchWishlist(userId: _userID);

    wishlist.fold(
      (error) => emit(
        WishlistError(error),
      ),
      (wishlistItems) async {
        var result = await productsUseCase.call(
          productIds: wishlistItems,
          
        );

        result.fold(
          (error) {
            emit(WishlistError(error.toString()));
          },
          (wishlistProducts) {
            emit(WishlistLoaded(wishlistProducts));
          },
        );
      },
    );
  }

  Future<void> clearWishlist() async {
    await _localSources.clearWishlist(userId: _userID);
  }
}
