import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/use_cases.dart';
import 'package:t_store/features/personalization/data/models/upload_image_model.dart';
import 'package:t_store/features/personalization/domain/repository/user_repository.dart';
import 'package:t_store/core/config/service_locator.dart';

class UploadUserImageUseCase extends UseCases<Either, UploadImageModel> {
  @override
  Future<Either> call({UploadImageModel? params}) async {
    return await getIt<UserRepository>()
        .uploadUserImage(params!.path, params.image);
  }
}
