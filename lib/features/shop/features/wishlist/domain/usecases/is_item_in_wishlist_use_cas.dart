import 'package:t_store/common/core/usecases/use_cases.dart';
import 'package:t_store/features/shop/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:t_store/config/service_locator.dart';

class IsItemInWishlistUseCas extends UseCases<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await getIt<WishlistRepository>().isProductInWishlist(params!);
  }
}
