import 'package:t_store/features/personalization/domain/repository/upload_data_repository.dart';
import 'package:t_store/core/config/service_locator.dart';

class UploadDummyDataUseCase {
  Future call({required List<dynamic> data, required String collection}) async {
    return await getIt<UploadDataRepository>()
        .uploadDummyData(data, collection);
  }
}
