import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/all_brands/domain/entities/brand_entity.dart';
import 'package:t_store/features/shop/features/all_brands/domain/usecases/get_all_brands_use_case.dart';
import 'package:t_store/features/shop/features/all_brands/domain/usecases/get_featured_brands_use_case.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/cubits/brand_state.dart';
import 'package:t_store/service_locator.dart';

class BrandCubit extends Cubit<BrandState> {
  BrandCubit() : super(BrandInitial());

  final List<BrandEntity> featuredBrands = [];
  final List<BrandEntity> allBrands = [];

  // --flag to check if the brands are already loaded--
  bool isAllBrandsLoaded = false;
  bool isFeaturedBrandsLoaded = false;

  // -- Get Featured Brands --
  Future<void> fetchFeaturedBrands() async {
    if (isFeaturedBrandsLoaded) {
      if (kDebugMode) {
        print('Featured Brands: Already Loaded');
      }

      return;
    }

    emit(BrandLoading(
      isLoadingFeaturedBrands: true,
    ));

    var result = await getIt.get<GetFeaturedBrandsUseCase>().call(params: 4);

    if (isClosed) return;

    result.fold(
      (error) => emit(
        BrandError(featuredBrandsMessage: error),
      ),
      (brands) {
        featuredBrands.clear();
        featuredBrands.addAll(brands);
        if (kDebugMode) {
          print('Featured Brands: Success');
        }
        isFeaturedBrandsLoaded = true;
        emit(BrandLoaded(featuredBrands: brands, allbrands: allBrands));
      },
    );
  }

  // -- Get All Brands --
  Future<void> fetchAllBrands() async {
    if (isAllBrandsLoaded) {
      if (kDebugMode) {
        print('All Brands: Already Loaded');
      }
      return;
    }

    emit(BrandLoading(
      isLoadingAllBrands: true,
    ));

    var result = await getIt.get<GetAllBrandsUseCase>().call(params: 16);

    if (isClosed) return;

    result.fold(
      (error) => emit(BrandError(allBrandsMessage: error)),
      (brands) {
        allBrands.clear();
        allBrands.addAll(brands);
        if (kDebugMode) {
          print('All Brands: Success');
        }
        isAllBrandsLoaded = true;
        emit(BrandLoaded(allbrands: brands, featuredBrands: featuredBrands));
      },
    );
  }

  // -- Refresh Brands --
  void refreshBrands() {
    isAllBrandsLoaded = false;
    isFeaturedBrandsLoaded = false;
    fetchAllBrands();
    fetchFeaturedBrands();
  }

  // -- Clear Brands --
  void clearBrands() {
    allBrands.clear();
    featuredBrands.clear();
    isAllBrandsLoaded = false;
    isFeaturedBrandsLoaded = false;
  }
}
