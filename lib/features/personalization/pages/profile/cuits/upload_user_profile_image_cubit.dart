import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store/features/personalization/data/models/upload_image_model.dart';
import 'package:t_store/features/personalization/domain/use_cases/upload_user_image_use_case.dart';
import 'package:t_store/features/personalization/pages/profile/cuits/upload_user_profile_image_state.dart';
import 'package:t_store/config/service_locator.dart';

class UploadUserProfileImageCubit extends Cubit<UploadUserProfileImageState> {
  UploadUserProfileImageCubit() : super(UploadUserProfileImageInitialState());

  void uploadUserImage() async {
    // Pick image
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 70,
    );

    if (image != null) {
      emit(UplaodUserProfileImageLoadingState());

      final UploadImageModel imageModel =
          UploadImageModel(path: 'Users/Images/Profile/', image: image);

      var result =
          await getIt<UploadUserImageUseCase>().call(params: imageModel);

      result.fold(
        (error) {
          emit(UploadUserProfileImageFailureState(error));
        },
        (url) {
          emit(UploadUserProfileImageSuccessState(url));
        },
      );
    } else {
      emit(NotSelectImageState());
    }
  }
}
