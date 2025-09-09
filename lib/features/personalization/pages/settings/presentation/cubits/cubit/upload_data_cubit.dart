import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/personalization/data/models/products/product_upload_model.dart';
import 'package:t_store/features/personalization/domain/repository/upload_data_repository.dart';
import 'package:t_store/features/personalization/domain/use_cases/upload_data_usecases/upload_categories_use_case.dart';
import 'package:t_store/features/personalization/domain/use_cases/upload_data_usecases/upload_product_use_case.dart';
import 'package:t_store/core/config/service_locator.dart';
import 'package:t_store/core/utils/constants/images_strings.dart';

part 'upload_data_state.dart';

class UploadDataCubit extends Cubit<UploadDataState> {
  UploadDataCubit() : super(UploadDataInitial());

  void uploadDummyData(
      {required List<dynamic> data, required String collection}) async {
    emit(UploadDataloading(
        'We are uploading $collection data...', TImages.packaging));
    try {
      await getIt<UploadDummyDataUseCase>()
          .call(data: data, collection: collection);
      emit(UploadDataSuccess('Successfully Uploaded $collection'));
    } catch (e) {
      emit(UploadDataFailure(e.toString()));
    }
  }

  void uploadProductDummyData(
      {required List<ProductUploadModel> data,
      required String collection}) async {
    emit(UploadDataloading(
        'We are uploading $collection data...', TImages.packaging));
    try {
      await getIt<UploadProductUseCase>()
          .call(data: data, collection: collection);
      emit(UploadDataSuccess('Successfully Uploaded $collection'));
    } catch (e) {
      emit(UploadDataFailure(e.toString()));
    }
  }

  void deleteDummyData({required String collection}) async {
    emit(UploadDataloading(
        'We are deleting $collection data', TImages.loadingJuggle));
    try {
      await getIt<UploadDataRepository>().deleteDummyData(collection);
      emit(UploadDataSuccess('Delete $collection Successfully'));
    } catch (e) {
      emit(UploadDataFailure(e.toString()));
    }
  }
}
