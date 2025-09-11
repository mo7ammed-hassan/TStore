part of 'upload_data_cubit.dart';

sealed class UploadDataState {}

final class UploadDataInitial extends UploadDataState {}

final class UploadDataloading extends UploadDataState {
  final String message;
  final String animation;

  UploadDataloading(this.message, this.animation);
}

final class UploadDataSuccess extends UploadDataState {
  final String message;

  UploadDataSuccess(this.message);
}

final class UploadDataFailure extends UploadDataState {
  final String error;

  UploadDataFailure(this.error);
}

final class UploadDataDeletingState extends UploadDataState {
  final String message;
  UploadDataDeletingState(this.message);
}
