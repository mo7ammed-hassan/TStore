import 'package:t_store/features/personalization/data/models/products/product_upload_model.dart';
import 'package:t_store/features/personalization/data/source/remote/uplaod_data_firebase_services.dart';
import 'package:t_store/features/personalization/domain/repository/upload_data_repository.dart';
import 'package:t_store/config/service_locator.dart';

class UploadDataRepositoryImpl extends UploadDataRepository {
  @override
  Future<void> uploadDummyData(List<dynamic> data, String collection) async {
    return await getIt<UploadDataFirebaseServices>()
        .uploadDummyData(data, collection);
  }

  @override
  Future<void> uploadProductData(
      List<ProductUploadModel> data, String collection) async {
    return await getIt<UploadDataFirebaseServices>()
        .uploadProductData(data, collection);
  }

  @override
  Future<void> deleteDummyData(String collection) async {
    return await getIt<UploadDataFirebaseServices>()
        .deleteDummyData(collection);
  }
}
