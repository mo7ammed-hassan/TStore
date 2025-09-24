import 'package:get_it/get_it.dart';
import 'package:t_store/core/network/api_client.dart';
import 'package:t_store/features/payment/data/datasources/cash_payment_service.dart';
import 'package:t_store/features/payment/data/datasources/customer_service/i_customer_service.dart';
import 'package:t_store/features/payment/data/datasources/customer_service/stripe_customer_sevice.dart';
import 'package:t_store/features/payment/data/datasources/fawry_payment_service.dart';
import 'package:t_store/features/payment/data/datasources/i_card_flow_strategy.dart';
import 'package:t_store/features/payment/data/datasources/i_payment_service_strategy.dart';
import 'package:t_store/features/payment/data/datasources/payment_method_service/i_payment_method_service.dart';
import 'package:t_store/features/payment/data/datasources/payment_method_service/stripe_payment_method_service.dart';
import 'package:t_store/features/payment/data/datasources/payment_remote_datasource.dart';
import 'package:t_store/features/payment/data/datasources/paypal_service/paypal_payment_service.dart';
import 'package:t_store/features/payment/data/datasources/stripe_service/stripe_new_card_flow_strategy.dart';
import 'package:t_store/features/payment/data/datasources/stripe_service/stripe_payment_service.dart';
import 'package:t_store/features/payment/data/datasources/stripe_service/stripe_saved_card_flow_strategy.dart';
import 'package:t_store/features/payment/data/datasources/vodafone_cash_payment_service.dart';
import 'package:t_store/features/payment/data/repositories/customer_repository_impl.dart';
import 'package:t_store/features/payment/data/repositories/payment_method_repository_impl.dart';
import 'package:t_store/features/payment/data/repositories/payment_repository_impl.dart';
import 'package:t_store/features/payment/domain/repositories/customer_repository.dart';
import 'package:t_store/features/payment/domain/repositories/payment_method_repository.dart';
import 'package:t_store/features/payment/domain/repositories/payment_repository.dart';
import 'package:t_store/features/payment/domain/usecases/delete_customer_usecase.dart';
import 'package:t_store/features/payment/domain/usecases/get_default_payment_method.dart';
import 'package:t_store/features/payment/domain/usecases/get_payment_methods_usecase.dart';
import 'package:t_store/features/payment/domain/usecases/get_saved_payment_methods_usecase.dart';
import 'package:t_store/features/payment/domain/usecases/pay_usecase.dart';
import 'package:t_store/features/payment/domain/usecases/payment_usecases.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:t_store/features/payment/presentation/cubit/payment_methods_cubit.dart';

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
    () => StripeNewCardFlowStrategy(
      ApiClient.instance,
      getIt(instanceName: 'stripeCustomer'),
    ),
    instanceName: 'stripeNewCardFlow',
  );

  getIt.registerLazySingleton<ICardFlowStrategy>(
    () => StripeSavedCardFlowStrategy(
      ApiClient.instance,
      getIt(instanceName: 'stripeCustomer'),
    ),
    instanceName: 'stripeSavedCardFlow',
  );

  /// --- Payment Method Services --- ///
  getIt.registerLazySingleton<IPaymentMethodService>(
    () => StripePaymentMethodService(getIt()),
  );

  /// Card
  getIt.registerFactory<IPaymentServiceStrategy>(
    () => StripePaymentService(getIt(instanceName: 'stripeNewCardFlow')),
    instanceName: 'stripeNewCard',
  );

  getIt.registerFactory<IPaymentServiceStrategy>(
    () => StripePaymentService(getIt(instanceName: 'stripeSavedCardFlow')),
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
  getIt.registerLazySingleton<PaymentMethodRepository>(
    () => PaymentMethodRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<CustomerRepository>(
    () => CustomerRepositoryImpl(getIt(instanceName: 'stripeCustomer')),
  );

  /// --- UseCases --- ///
  getIt.registerLazySingleton<PayUseCase>(
    () => PayUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetPaymentMethodsUsecase>(
    () => GetPaymentMethodsUsecase(getIt()),
  );
  getIt.registerLazySingleton<GetDefaultPaymentMethod>(
    () => GetDefaultPaymentMethod(getIt()),
  );
  getIt.registerLazySingleton<PaymentUsecases>(
    () => PaymentUsecases(getIt(), getIt()),
  );

  getIt.registerLazySingleton<GetSavedPaymentMethodsUsecase>(
    () => GetSavedPaymentMethodsUsecase(getIt()),
  );

  getIt.registerFactory<DeleteCustomerUsecase>(
    () => DeleteCustomerUsecase(getIt()),
  );

  /// --- Payment Cubit --- ///
  getIt.registerFactory<PaymentCubit>(
    () => PaymentCubit(getIt()),
  );

  getIt.registerFactory<PaymentMethodsCubit>(
    () => PaymentMethodsCubit(getIt(), getIt()),
  );
}
