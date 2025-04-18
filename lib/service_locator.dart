import 'package:get_it/get_it.dart';
import 'package:t_store/common/core/hive_boxes/open_boxes.dart';
import 'package:t_store/features/authentication/data/repository/authentication_repository_impl.dart';
import 'package:t_store/features/authentication/data/repository/onboarding_repository_impl.dart';
import 'package:t_store/features/authentication/data/source/authentication_source/authentication_firebase_services.dart';
import 'package:t_store/features/authentication/domain/repository/authentication_repository.dart';
import 'package:t_store/features/authentication/domain/repository/onboarding_repository.dart';
import 'package:t_store/features/authentication/domain/use_cases/is_first_launch_use_case.dart';
import 'package:t_store/features/authentication/domain/use_cases/is_verified_email_use_case.dart';
import 'package:t_store/features/authentication/domain/use_cases/logout_use_case.dart';
import 'package:t_store/features/authentication/domain/use_cases/reset_password_usecase.dart';
import 'package:t_store/features/authentication/domain/use_cases/send_email_verification_usecase.dart';
import 'package:t_store/features/authentication/domain/use_cases/signin_usecase.dart';
import 'package:t_store/features/authentication/domain/use_cases/signin_with_google.dart';
import 'package:t_store/features/authentication/domain/use_cases/signup_usecase.dart';
import 'package:t_store/features/personalization/data/repository/upload_data_repository_impl.dart';
import 'package:t_store/features/personalization/data/repository/user_repository_impl.dart';
import 'package:t_store/features/personalization/data/source/remote/firebase_storage_services.dart';
import 'package:t_store/features/personalization/data/source/remote/uplaod_data_firebase_services.dart';
import 'package:t_store/features/personalization/data/source/remote/user_firebase_services.dart';
import 'package:t_store/features/personalization/domain/repository/upload_data_repository.dart';
import 'package:t_store/features/personalization/domain/repository/user_repository.dart';
import 'package:t_store/features/personalization/domain/use_cases/delete_account_use_case.dart';
import 'package:t_store/features/personalization/domain/use_cases/delete_user_account_use_case.dart';
import 'package:t_store/features/personalization/domain/use_cases/fetch_user_data_use_case.dart';
import 'package:t_store/features/personalization/domain/use_cases/re_auth_user_account_use_case.dart';
import 'package:t_store/features/personalization/domain/use_cases/update_user_filed_use_case.dart';
import 'package:t_store/features/personalization/domain/use_cases/upload_data_usecases/upload_categories_use_case.dart';
import 'package:t_store/features/personalization/domain/use_cases/upload_data_usecases/upload_product_use_case.dart';
import 'package:t_store/features/personalization/domain/use_cases/upload_user_image_use_case.dart';
import 'package:t_store/features/personalization/pages/address/data/repositories/address_repository_impl.dart';
import 'package:t_store/features/personalization/pages/address/data/source/address_firebase_services.dart';
import 'package:t_store/features/personalization/pages/address/domain/repositories/address_repository.dart';
import 'package:t_store/features/personalization/pages/address/domain/usecases/add_address_use_case.dart';
import 'package:t_store/features/personalization/pages/address/domain/usecases/delete_address_use_case.dart';
import 'package:t_store/features/personalization/pages/address/domain/usecases/fetch_all_address_use_case.dart';
import 'package:t_store/features/shop/features/all_brands/data/repository/brands_repository_impl.dart';
import 'package:t_store/features/shop/features/all_brands/data/source/brands_firebase_services.dart';
import 'package:t_store/features/shop/features/all_brands/domain/repository/brands_repository.dart';
import 'package:t_store/features/shop/features/all_brands/domain/usecases/get_all_brands_use_case.dart';
import 'package:t_store/features/shop/features/all_brands/domain/usecases/get_brands_specific_category.dart';
import 'package:t_store/features/shop/features/all_brands/domain/usecases/get_featured_brands_use_case.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/cubits/brand_cubit.dart';
import 'package:t_store/features/shop/features/all_products/data/repository/product_repository_impl.dart';
import 'package:t_store/features/shop/features/all_products/data/source/product_firebase_services.dart';
import 'package:t_store/features/shop/features/all_products/domain/repository/product_repository.dart';
import 'package:t_store/features/shop/features/all_products/domain/usecases/get_all_products_by_brand_use_cse.dart';
import 'package:t_store/features/shop/features/all_products/domain/usecases/get_popular_products_use_case.dart';
import 'package:t_store/features/shop/features/all_products/domain/usecases/get_fetured_products_use_case.dart';
import 'package:t_store/features/shop/features/all_products/domain/usecases/get_products_specific_category_use_case.dart';
import 'package:t_store/features/shop/features/all_products/presentation/cubits/products_cubit.dart';
import 'package:t_store/features/shop/features/cart/data/mappers_or_factories/cart_item_factory.dart';
import 'package:t_store/features/shop/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:t_store/features/shop/features/cart/data/source/cart_local_storage_services.dart';
import 'package:t_store/features/shop/features/cart/data/source/cart_managment_service.dart';
import 'package:t_store/features/shop/features/cart/domain/repositories/cart_repository.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/add_product_to_cart_use_case.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/add_single_cart_item_use_case.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/fetch_cart_items_use_case.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/get_item_quantity_by_variation_use_case.dart';
import 'package:t_store/features/shop/features/cart/domain/usecases/remover_single_cart_item_use_case.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/features/shop/features/home/data/repository/banner_repository_impl.dart';
import 'package:t_store/features/shop/features/home/data/repository/category_repository_impl.dart';
import 'package:t_store/features/shop/features/home/data/source/remote/banner_firebase_services.dart';
import 'package:t_store/features/shop/features/home/data/source/remote/category_firebase_services.dart';
import 'package:t_store/features/shop/features/home/domain/repository/banner_repository.dart';
import 'package:t_store/features/shop/features/home/domain/repository/category_repositoy.dart';
import 'package:t_store/features/shop/features/home/domain/use_cases/banner_use_case.dart';
import 'package:t_store/features/shop/features/home/domain/use_cases/category_use_case.dart';
import 'package:t_store/features/shop/features/product_details/presentation/cubits/product_variation_cubit.dart';
import 'package:t_store/features/shop/features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'package:t_store/features/shop/features/wishlist/data/source/wishlist_firebase_services.dart';
import 'package:t_store/features/shop/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:t_store/features/shop/features/wishlist/domain/usecases/add_items_in_wishlist_use_case.dart';
import 'package:t_store/features/shop/features/wishlist/domain/usecases/fetch_wishlist_items_use_case.dart';
import 'package:t_store/features/shop/features/wishlist/domain/usecases/remove_item_from_wishlist_use_case.dart';
import 'package:t_store/features/shop/features/wishlist/presentation/pages/cubits/favorite_button_cubit.dart';
import 'package:t_store/features/shop/features/wishlist/presentation/pages/cubits/wishlist_cubit.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // ------Services------
  // --Remote
  getIt.registerFactory<AuthenticationFirebaseServices>(
    () => AuthenticationFirebaseServicesImpl(),
  );
  getIt.registerFactory<UserFirebaseServices>(
    () => UserFirebaseServiceImpl(),
  );
  getIt.registerSingleton<CategoryFirebaseServices>(
    CategoryFirebaseServicesImpl(),
  );
  getIt.registerFactory<FirebaseStorageServices>(
    () => FirebaseStorageServicesImpl(),
  );
  getIt.registerSingleton<UploadDataFirebaseServices>(
    UploadDataFirebaseServicesImpl(),
  );
  getIt.registerSingleton<BannerFirebaseServices>(
    BannerFirebaseServicesImpl(),
  );
  getIt.registerSingleton<WishlistFirebaseServices>(
    WishlistFirebaseServicesImpl(),
  );
  getIt.registerLazySingleton<ProductVariationCubit>(
      () => ProductVariationCubit());
  getIt.registerLazySingleton<CartLocalStorageServices>(
    () => CartLocalStorageServicesImpl(),
  );
  
  getIt.registerSingleton<DefaultCartItemFactory>(
    DefaultCartItemFactory(getIt.get<ProductVariationCubit>()),
  );
  getIt.registerLazySingleton<CartManagementService>(
    () => CartManagementServiceImpl(
      getIt.get<CartLocalStorageServices>(), // Use get_it to get the instance
      getIt.get<DefaultCartItemFactory>(),
    ),
  );

  // ------Repositories------
  getIt.registerSingleton<OnboardingRepository>(
    OnboardingRepositoryImpl(),
  );
  getIt.registerFactory<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(),
  );
  getIt.registerFactory<UserRepository>(
    () => UserRepositoryImpl(),
  );
  getIt.registerSingleton<CategoryRepository>(
    CategoryRepositoyImpl(),
  );
  getIt.registerSingleton<ProductRepository>(
    ProductRepositoryImpl(ProductFirebaseServicesImpl()),
  );
  getIt.registerSingleton<UploadDataRepository>(
    UploadDataRepositoryImpl(),
  );
  getIt.registerSingleton<BannerRepository>(
    BannerRepositoryImpl(),
  );
  getIt.registerSingleton<WishlistRepository>(
    WishlistRepositoryImpl(
      WishlistFirebaseServicesImpl(),
    ),
  );

  getIt.registerSingleton<CartRepository>(
    CartRepositoryImpl(
      getIt.get<CartManagementService>(),
      getIt.get<CartLocalStorageServices>(),
    ),
  );

  // ------Usecases------
  getIt.registerLazySingleton<IsFirstLaunchUseCase>(
    () => IsFirstLaunchUseCase(),
  );
  getIt.registerFactory<SignupUsecase>(
    () => SignupUsecase(),
  );
  getIt.registerFactory<SendEmailVerificationUsecase>(
    () => SendEmailVerificationUsecase(),
  );

  getIt.registerFactory<IsVerifiedEmailUseCase>(
    () => IsVerifiedEmailUseCase(),
  );

  getIt.registerFactory<SignInUsecase>(
    () => SignInUsecase(),
  );
  getIt.registerSingleton<ResetPasswordUsecase>(
    ResetPasswordUsecase(),
  );
  getIt.registerFactory<LogoutUseCase>(
    () => LogoutUseCase(),
  );
  getIt.registerFactory<SigninWithGoogleUseCase>(
    () => SigninWithGoogleUseCase(),
  );
  getIt.registerFactory<FetchUserDataUseCase>(
    () => FetchUserDataUseCase(),
  );
  getIt.registerSingleton<UpdateUserFiledUseCase>(
    UpdateUserFiledUseCase(),
  );
  getIt.registerFactory<ReAuthUserAccountUseCase>(
    () => ReAuthUserAccountUseCase(),
  );
  getIt.registerFactory<DeleteUserAccountUseCase>(
    () => DeleteUserAccountUseCase(),
  );
  getIt.registerFactory<DeleteAccountUseCase>(
    () => DeleteAccountUseCase(),
  );
  getIt.registerSingleton<UploadUserImageUseCase>(
    UploadUserImageUseCase(),
  );
  getIt.registerSingleton<CategoryUseCase>(
    CategoryUseCase(),
  );

  // --Brands--
  getIt.registerSingleton<BrandsRepository>(
    BrandsRepositoryImpl(
      BrandsFirebaseServicesImpl(),
    ),
  );
  getIt.registerSingleton<GetAllBrandsUseCase>(
    GetAllBrandsUseCase(getIt.get<BrandsRepository>()),
  );

  getIt.registerSingleton<GetFeaturedBrandsUseCase>(
    GetFeaturedBrandsUseCase(getIt.get<BrandsRepository>()),
  );
  getIt.registerSingleton<GetBrandsSpecificCategory>(
    GetBrandsSpecificCategory(getIt.get<BrandsRepository>()),
  );

  // --Upload Data
  getIt.registerSingleton<UploadDummyDataUseCase>(
    UploadDummyDataUseCase(),
  );
  getIt.registerSingleton<UploadProductUseCase>(
    UploadProductUseCase(),
  );
  // --Banners
  getIt.registerSingleton<BannerUseCase>(
    BannerUseCase(),
  );
  // --Products
  getIt.registerSingleton<GetPopularProductsUseCase>(
    GetPopularProductsUseCase(),
  );
  getIt.registerSingleton<GetFeturedProductsUseCase>(
    GetFeturedProductsUseCase(),
  );
  getIt.registerSingleton<GetAllProductsByBrandUseCse>(
    GetAllProductsByBrandUseCse(),
  );
  getIt.registerSingleton<GetProductsSpecificCategoryUseCase>(
    GetProductsSpecificCategoryUseCase(),
  );
  // -- wishlist --
  getIt.registerSingleton<AddItemsInWishlistUseCase>(
    AddItemsInWishlistUseCase(),
  );
  getIt.registerSingleton<RemoveItemFromWishlistUseCase>(
    RemoveItemFromWishlistUseCase(),
  );
  getIt.registerSingleton<FetchWishlistItemsUseCase>(
    FetchWishlistItemsUseCase(),
  );

  // -- Address--
  getIt.registerSingleton<AddressRepository>(
    AddressRepositoryImpl(
      AddressFirebaseServicesImpl(),
    ),
  );
  getIt.registerSingleton<FetchAllAddressUseCase>(
    FetchAllAddressUseCase(getIt.get<AddressRepository>()),
  );
  getIt.registerSingleton<AddAddressUseCase>(
    AddAddressUseCase(getIt.get<AddressRepository>()),
  );
  getIt.registerSingleton<DeleteAddressUseCase>(
    DeleteAddressUseCase(getIt.get<AddressRepository>()),
  );

  // --Cart--
  getIt.registerLazySingleton<FetchCartItemsUseCase>(
    () => FetchCartItemsUseCase(getIt.get<CartRepository>()),
  );
  getIt.registerLazySingleton<AddSingleCartItemUseCase>(
    () => AddSingleCartItemUseCase(getIt.get<CartRepository>()),
  );
  getIt.registerLazySingleton<RemoverSingleCartItemUseCase>(
    () => RemoverSingleCartItemUseCase(getIt.get<CartRepository>()),
  );
  getIt.registerLazySingleton<AddProductToCartUseCase>(
    () => AddProductToCartUseCase(getIt.get<CartRepository>()),
  );
  getIt.registerLazySingleton<GetItemQuantityByVariationUseCase>(
    () => GetItemQuantityByVariationUseCase(getIt.get<CartRepository>()),
  );

  // -- Cubits--
  getIt.registerLazySingleton<ProductsCubit>(() => ProductsCubit());
  getIt.registerLazySingleton<BrandCubit>(() => BrandCubit());
  getIt.registerLazySingleton<WishlistCubit>(() => WishlistCubit());
  getIt.registerLazySingleton<FavoriteButtonCubit>(
    () => FavoriteButtonCubit(getIt.get<WishlistCubit>()),
  );
  getIt.registerLazySingleton<CartCubit>(
    () => CartCubit(),
  );

  // -- HIVE BOXES --
  getIt.registerLazySingleton<OpenBoxes>(() => OpenBoxes());
  
}
