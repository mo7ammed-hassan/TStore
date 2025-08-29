import 'package:get_it/get_it.dart';
import 'package:t_store/features/checkout/data/datasources/checkout_remote_data_source.dart';
import 'package:t_store/features/checkout/data/repositories/checkout_repository_impl.dart';
import 'package:t_store/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:t_store/features/checkout/domain/usecases/checkout_usecases.dart';
import 'package:t_store/features/checkout/domain/usecases/create_order_draft_usecase.dart';
import 'package:t_store/features/checkout/domain/usecases/sync_cart_with_server_usecase.dart';
import 'package:t_store/features/checkout/domain/usecases/update_order_payment_status_usecase.dart';
import 'package:t_store/features/checkout/presentation/cubits/checkout_cubit.dart';

void registerCheckoutDependencies(GetIt getIt) {
  getIt.registerLazySingleton<CheckoutRemoteDataSource>(
    () => CheckoutRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<CheckoutRepository>(
    () => CheckoutRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<SyncCartWithServerUseCase>(
    () => SyncCartWithServerUseCase(getIt()),
  );

  getIt.registerLazySingleton<UpdateOrderPaymentStatusUsecase>(
    () => UpdateOrderPaymentStatusUsecase(getIt()),
  );

  getIt.registerLazySingleton<CreateOrderDraftUsecase>(
    () => CreateOrderDraftUsecase(getIt()),
  );
  getIt.registerLazySingleton<CheckoutUsecases>(
    () => CheckoutUsecases(
      createOrderDraftUsecase: getIt(),
      syncCartWithServerUseCase: getIt(),
      updateOrderPaymentStatusUsecase: getIt(),
    ),
  );

  getIt.registerFactory<CheckoutCubit>(
    () => CheckoutCubit(getIt()),
  );
}
