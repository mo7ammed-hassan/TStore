import 'package:t_store/features/personalization/data/models/products/product_upload_model.dart';
import 'package:t_store/features/personalization/domain/repository/upload_data_repository.dart';
import 'package:t_store/core/config/service_locator.dart';

class UploadProductUseCase {
  Future call(
      {required List<ProductUploadModel> data, required String collection}) async {
    return await getIt<UploadDataRepository>()
        .uploadProductData(data, collection);
  }
}
