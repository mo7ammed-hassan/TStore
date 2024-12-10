part of 'upload_data_cubit.dart';

sealed class UploadDataState {}

final class UploadDataInitial extends UploadDataState {}

final class UploadDataloading extends UploadDataState {
   final String message;

  UploadDataloading(this.message);
}

final class UploadDataSuccess extends UploadDataState {
  final String message;

  UploadDataSuccess( this.message);
}

final class UploadDataFailure extends UploadDataState {
  final String error;

  UploadDataFailure(this.error);
}
