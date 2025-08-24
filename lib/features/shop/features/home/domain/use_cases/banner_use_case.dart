import 'package:dartz/dartz.dart';
import 'package:t_store/common/core/usecases/use_cases.dart';
import 'package:t_store/features/shop/features/home/domain/entites/banner_entity.dart';
import 'package:t_store/features/shop/features/home/domain/repository/banner_repository.dart';
import 'package:t_store/config/service_locator.dart';

class BannerUseCase
    extends UseCases<Either<String, List<BannerEntity>>, dynamic> {
  @override
  Future<Either<String, List<BannerEntity>>> call({params}) async {
    return await getIt<BannerRepository>().fetchBanners();
  }
}
