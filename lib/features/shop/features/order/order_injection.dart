import 'package:get_it/get_it.dart';
import 'package:t_store/features/shop/features/order/data/datasources/order_remote_data_sources.dart';
import 'package:t_store/features/shop/features/order/data/repositories/order_repository_impl.dart';
import 'package:t_store/features/shop/features/order/domain/repositories/order_repository.dart';
import 'package:t_store/features/shop/features/order/domain/usecases/cancel_order_usecase.dart';
import 'package:t_store/features/shop/features/order/domain/usecases/fetch_orders_usecase.dart';
import 'package:t_store/features/shop/features/order/domain/usecases/order_usecases.dart';
import 'package:t_store/features/shop/features/order/domain/usecases/update_order_status.dart';
import 'package:t_store/features/shop/features/order/presentation/cuits/order_cubit.dart';

void registerOrderDependencies(GetIt getIt) {
  getIt.registerLazySingleton<OrderRemoteDataSources>(
    () => OrderRemoteDataSourcesImpl(),
  );

  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<FetchOrdersUsecase>(
    () => FetchOrdersUsecase(getIt()),
  );

  getIt.registerLazySingleton<CancelOrderUsecase>(
    () => CancelOrderUsecase(getIt()),
  );

  getIt.registerLazySingleton<UpdateOrderStatusUsecase>(
    () => UpdateOrderStatusUsecase(getIt()),
  );

  getIt.registerLazySingleton<OrderUsecases>(
    () => OrderUsecases(
      fetchOrdersUsecase: getIt(),
      cancelOrderUsecase: getIt(),
      updateOrderStatusUsecase: getIt(),
    ),
  );

  getIt.registerFactory<OrderCubit>(
    () => OrderCubit(getIt()),
  );
}
