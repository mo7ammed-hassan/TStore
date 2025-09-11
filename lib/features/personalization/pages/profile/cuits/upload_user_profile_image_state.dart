abstract class UploadUserProfileImageState {}

class UploadUserProfileImageInitialState extends UploadUserProfileImageState {}

class UploadUserProfileImageSuccessState extends UploadUserProfileImageState {
  final String url;

  UploadUserProfileImageSuccessState(this.url);
}

class UploadUserProfileImageFailureState extends UploadUserProfileImageState {
  final String error;

  UploadUserProfileImageFailureState(this.error);
}

class UplaodUserProfileImageLoadingState extends UploadUserProfileImageState {}

class NotSelectImageState extends UploadUserProfileImageState {}
