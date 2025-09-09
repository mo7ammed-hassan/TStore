import 'package:t_store/core/usecases/use_cases.dart';
import 'package:t_store/features/authentication/domain/repository/onboarding_repository.dart';
import 'package:t_store/core/config/service_locator.dart';

class IsFirstLaunchUseCase extends UseCases<bool,dynamic> {
  @override
  Future<bool> call({params}) async {
    return await getIt<OnboardingRepository>().isFirstLaunch();
  }
}
