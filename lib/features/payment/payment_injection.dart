import 'package:get_it/get_it.dart';
import 'package:t_store/core/network/api_client.dart';
import 'package:t_store/features/payment/data/datasources/cash_payment_service.dart';
import 'package:t_store/features/payment/data/datasources/customer_service/i_customer_service.dart';
import 'package:t_store/features/payment/data/datasources/customer_service/stripe_customer_sevice.dart';
import 'package:t_store/features/payment/data/datasources/fawry_payment_service.dart';
import 'package:t_store/features/payment/data/datasources/i_card_flow_strategy.dart';
import 'package:t_store/features/payment/data/datasources/i_payment_service_strategy.dart';
import 'package:t_store/features/payment/data/datasources/pay_with_new_card.dart';
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
  /// --- API ---
  getIt.registerLazySingleton<ApiClient>(() => ApiClient.instance);

  /// --- Payment Firebase sevices --- ///
  getIt.registerLazySingleton<PaymentRemoteDatasource>(
    () => PaymentRemoteDatasourceImpl(),
  );

  /// --- /// --- Payment Services --- /// --- ///
  /// --- CustomerService --- ///
  getIt.registerLazySingleton<ICustomerService>(
    () => StripeCustomerService(getIt()),
    instanceName: 'stripeCustomer',
  );

  /// --- Card Flow Services --- ///
  getIt.registerLazySingleton<ICardFlowStrategy>(
    () => PayWithNewCardStrategy(
      ApiClient.instance,
      getIt(instanceName: 'stripeCustomer'),
    ),
    instanceName: 'stripeNewCardFlow',
  );

  getIt.registerLazySingleton<ICardFlowStrategy>(
    () => PayWithNewCardStrategy(
      ApiClient.instance,
      getIt(instanceName: 'stripeCustomer'),
    ),
    instanceName: 'stripeSavedCardFlow',
  );

  /// --- Payment Method Services --- ///
  /// Card
  getIt.registerFactory<IPaymentServiceStrategy>(
    () =>
        StripePaymentServiceStrategy(getIt(instanceName: 'stripeNewCardFlow')),
    instanceName: 'stripeNewCard',
  );
  getIt.registerFactory<IPaymentServiceStrategy>(
    () => StripePaymentServiceStrategy(
        getIt(instanceName: 'stripeSavedCardFlow')),
    instanceName: 'stripeSavedCard',
  );
  getIt.registerFactory<IPaymentServiceStrategy>(
    () => PayPalPaymentService(),
    instanceName: 'payPal',
  );

  ///---///
  getIt.registerFactory<IPaymentServiceStrategy>(
    () => VodafoneCashPaymentService(),
    instanceName: 'vodafone',
  );
  getIt.registerFactory<IPaymentServiceStrategy>(
    () => FawryPaymentService(),
    instanceName: 'fawry',
  );
  getIt.registerFactory<IPaymentServiceStrategy>(
    () => CashOnDeliveryPaymentService(),
    instanceName: 'cash',
  );

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
