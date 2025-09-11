import 'package:get_it/get_it.dart';
import 'package:t_store/features/shop/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:t_store/features/shop/features/cart/data/source/cart_local_storage_services.dart';
import 'package:t_store/features/shop/features/cart/data/source/cart_mangment_service.dart';
import 'package:t_store/features/shop/features/cart/domain/repositories/cart_repository.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/add_item_to_cart_usecase.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/cart_usecases.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/change_cart_item_quantity_usecase.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/clear_cart_use_case.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/fetch_cart_items_use_case.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/remove_item_from_cart_usecase.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';

void registerCartDependencies(GetIt getIt) {
  getIt.registerLazySingleton<CartLocalStorageServices>(
    () => CartLocalStorageServicesImpl(),
  );

  getIt.registerLazySingleton<CartManagementService>(
    () => CartManagementServiceImpl(
      getIt.get<CartLocalStorageServices>(),
    ),
  );
  getIt.registerSingleton<CartRepository>(
    CartRepositoryImpl(
      getIt.get<CartManagementService>(),
      getIt.get<CartLocalStorageServices>(),
    ),
  );

  getIt.registerLazySingleton<FetchCartItemsUseCase>(
    () => FetchCartItemsUseCase(getIt.get<CartRepository>()),
  );
  getIt.registerLazySingleton<AddItemToCartUsecase>(
    () => AddItemToCartUsecase(getIt.get<CartRepository>()),
  );
  getIt.registerLazySingleton<RemoveItemFromCartUsecase>(
    () => RemoveItemFromCartUsecase(getIt.get<CartRepository>()),
  );
  getIt.registerLazySingleton<ChangeCartItemQuantityUsecase>(
    () => ChangeCartItemQuantityUsecase(getIt.get<CartRepository>()),
  );

  getIt.registerLazySingleton<ClearCartUsecase>(
    () => ClearCartUsecase(getIt.get<CartRepository>()),
  );

  getIt.registerLazySingleton<CartUsecases>(
    () => CartUsecases(getIt(), getIt(), getIt(), getIt(), getIt()),
  );

  getIt.registerFactory<CartCubit>(
    () => CartCubit(getIt.get<CartUsecases>()),
  );
}
