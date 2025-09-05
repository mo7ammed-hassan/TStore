import 'package:get_it/get_it.dart';
import 'package:t_store/features/payment/data/datasources/cash_payment_service.dart';
import 'package:t_store/features/payment/data/datasources/fawry_payment_service.dart';
import 'package:t_store/features/payment/data/datasources/i_payment_service.dart';
import 'package:t_store/features/payment/data/datasources/payment_remote_datasource.dart';
import 'package:t_store/features/payment/data/datasources/paypal_payment_service.dart';
import 'package:t_store/features/payment/data/datasources/stripe_payment_service.dart';
import 'package:t_store/features/payment/data/datasources/vodafone_cash_payment_service.dart';
import 'package:t_store/features/payment/data/repositories/payment_repository_impl.dart';
import 'package:t_store/features/payment/domain/repositories/payment_repository.dart';
import 'package:t_store/features/payment/domain/usecases/get_payment_methods_usecase.dart';
import 'package:t_store/features/payment/domain/usecases/pay_usecase.dart';
import 'package:t_store/features/payment/domain/usecases/payment_usecases.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_cubit.dart';

void registerPaymentDependencies(GetIt getIt) {
  getIt.registerLazySingleton<PaymentRemoteDatasource>(
    () => PaymentRemoteDatasourceImpl(),
  );

  /// --- Payment Services --- ///
  getIt.registerFactory<IPaymentService>(() => StripePaymentService(),
      instanceName: 'stripe');

  getIt.registerFactory<IPaymentService>(() => VodafoneCashPaymentService(),
      instanceName: 'vodafone');
  getIt.registerFactory<IPaymentService>(() => FawryPaymentService(),
      instanceName: 'fawry');
  getIt.registerFactory<IPaymentService>(() => CashOnDeliveryPaymentService(),
      instanceName: 'cash');
  getIt.registerFactory<IPaymentService>(() => PayPalPaymentService(),
      instanceName: 'payPal');

  /// --- Repository ---- ///
  getIt.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(getIt()),
  );

  /// --- UseCases --- ///
  getIt.registerLazySingleton<PayUseCase>(
    () => PayUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetPaymentMethodsUsecase>(
    () => GetPaymentMethodsUsecase(getIt()),
  );
  getIt.registerLazySingleton<PaymentUsecases>(
    () => PaymentUsecases(getIt(), getIt()),
  );

  /// --- Payment Cubit --- ///
  getIt.registerFactory<PaymentCubit>(
    () => PaymentCubit(getIt()),
  );
}
