import 'package:t_store/common/core/usecases/use_cases.dart';
import 'package:t_store/features/shop/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:t_store/config/service_locator.dart';

class ClearWishlistUseCase extends UseCases<void, dynamic> {
  @override
  Future<void> call({dynamic params}) async {
    return await getIt<WishlistRepository>().clearWishlist();
  }
}
