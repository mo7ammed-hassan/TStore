import 'package:dartz/dartz.dart';
import 'package:t_store/features/shop/features/home/data/models/banner_model.dart';
import 'package:t_store/features/shop/features/home/data/source/remote/banner_firebase_services.dart';
import 'package:t_store/features/shop/features/home/domain/entites/banner_entity.dart';
import 'package:t_store/features/shop/features/home/domain/repository/banner_repository.dart';
import 'package:t_store/core/config/service_locator.dart';

class BannerRepositoryImpl extends BannerRepository {
  @override
  Future<Either<String, List<BannerEntity>>> fetchBanners() async {
    var returnedData = await getIt<BannerFirebaseServices>().fetchBanners();

    return returnedData.fold(
      (error) => Left(error),
      (data) {
        List<BannerEntity> banners = List.from(data)
            .map((document) => BannerModel.fromJson(document).toEntity())
            .toList();

        return Right(banners);
      },
    );
  }
}
