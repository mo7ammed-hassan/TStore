import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/use_cases.dart';
import 'package:t_store/features/shop/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:t_store/core/config/service_locator.dart';

class FetchWishlistItemsUseCase
    extends UseCases<Either<dynamic, List<String>>, dynamic> {
  @override
  Future<Either<dynamic, List<String>>> call({dynamic params}) async {
    return await getIt<WishlistRepository>().fetchWishlist();
  }
}
