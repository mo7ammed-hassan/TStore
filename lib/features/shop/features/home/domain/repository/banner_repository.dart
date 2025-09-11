import 'package:dartz/dartz.dart';
import 'package:t_store/features/shop/features/home/domain/entites/banner_entity.dart';

abstract class BannerRepository {
  Future<Either<String, List<BannerEntity>>> fetchBanners();
}
