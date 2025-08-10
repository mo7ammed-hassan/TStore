import 'package:get_it/get_it.dart';
import 'package:t_store/features/personalization/pages/address/data/repositories/address_repository_impl.dart';
import 'package:t_store/features/personalization/pages/address/data/source/address_firebase_services.dart';
import 'package:t_store/features/personalization/pages/address/data/source/address_local_datasource.dart';
import 'package:t_store/features/personalization/pages/address/domain/repositories/address_repository.dart';
import 'package:t_store/features/personalization/pages/address/domain/usecases/add_address_use_case.dart';
import 'package:t_store/features/personalization/pages/address/domain/usecases/address_usecases.dart';
import 'package:t_store/features/personalization/pages/address/domain/usecases/delete_address_use_case.dart';
import 'package:t_store/features/personalization/pages/address/domain/usecases/fetch_all_address_use_case.dart';
import 'package:t_store/features/personalization/pages/address/domain/usecases/update_address_usecase.dart';
import 'package:t_store/features/personalization/pages/address/presentation/cubits/address_cubit.dart';

void registerAddressDependencies(GetIt getIt) {
  getIt.registerLazySingleton<AddressRepository>(
    () => AddressRepositoryImpl(
      AddressFirebaseServicesImpl(),
    ),
  );

  getIt.registerLazySingleton<FetchAllAddressUseCase>(
    () => FetchAllAddressUseCase(getIt.get<AddressRepository>()),
  );

  getIt.registerLazySingleton<AddAddressUseCase>(
    () => AddAddressUseCase(getIt.get<AddressRepository>()),
  );

  getIt.registerLazySingleton<DeleteAddressUseCase>(
    () => DeleteAddressUseCase(getIt.get<AddressRepository>()),
  );

  getIt.registerLazySingleton<UpdateAddressUsecase>(
    () => UpdateAddressUsecase(getIt.get<AddressRepository>()),
  );

  getIt.registerLazySingleton<AddressUsecases>(
    () => AddressUsecases(getIt(), getIt(), getIt(), getIt()),
  );

  getIt.registerFactory<AddressCubit>(
    () => AddressCubit(getIt(), AddressLocalDataSourceImpl()),
  );
}
