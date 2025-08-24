import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/all_products/domain/usecases/get_popular_products_use_case.dart';
import 'package:t_store/features/shop/features/all_products/domain/usecases/get_fetured_products_use_case.dart';
import 'package:t_store/features/shop/features/all_products/presentation/cubits/products_state.dart';
import 'package:t_store/config/service_locator.dart';
import 'package:t_store/utils/constants/enums.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitialState());

  final List<ProductEntity> allProducts = [];
  final List<ProductEntity> featuredProducts = [];

  bool _hasFetchedPopularProducts = false;
  bool _hasFetchedFeaturedProducts = false;

  Future<void> fetchPopularProducts({bool forceRefresh = false}) async {
    if (!forceRefresh && _hasFetchedPopularProducts && allProducts.isNotEmpty) {
      return;
    }

    emit(
      ProductsLoadingState(
        isLoadingAllProducts: true,
      ),
    );

    var result = await getIt<GetPopularProductsUseCase>().call();

    if (isClosed) return;

    result.fold(
      (error) {
        emit(ProductsFailureState(allProductsError: error));
      },
      (products) {
        allProducts.clear();
        allProducts.addAll(products);

        emit(ProductsLoadedState(allProducts, featuredProducts));
        _hasFetchedPopularProducts = true;
      },
    );
  }

  Future<void> fetchFeaturedProducts(
      {bool forceRefresh = false, int limit = 4}) async {
    if (!forceRefresh &&
        _hasFetchedFeaturedProducts &&
        featuredProducts.isNotEmpty &&
        featuredProducts.length == limit) {
      return;
    }

    emit(
      ProductsLoadingState(
        isLoadingFeaturedProducts: true,
      ),
    );

    var result = await getIt<GetFeturedProductsUseCase>().call(params: limit);

    if (isClosed) return;

    result.fold(
      (error) {
        emit(ProductsFailureState(featuredProductsError: error));
      },
      (products) {
        featuredProducts.clear();
        featuredProducts.addAll(products);

        emit(ProductsLoadedState(allProducts, featuredProducts));
        _hasFetchedFeaturedProducts = true;
      },
    );
  }

  Future<void> fetchInitialData() async {
    if (_hasFetchedFeaturedProducts && _hasFetchedPopularProducts) return;

    await Future.wait([
      fetchPopularProducts(forceRefresh: true).catchError((_) {}),
      fetchFeaturedProducts(forceRefresh: true).catchError((_) {}),
    ]);
  }

  // This method is used to refresh the products
  Future<void> refreshProducts() async {
    _hasFetchedFeaturedProducts = false;
    _hasFetchedPopularProducts = false;
    allProducts.clear();
    featuredProducts.clear();
    await fetchPopularProducts(forceRefresh: true);
    await fetchFeaturedProducts(forceRefresh: true);
  }

  String getProductPrice(ProductEntity product) {
    if (product.productType == ProductType.single.toString()) {
      double price = (product.salePrice != null && product.salePrice! > 0)
          ? product.salePrice!
          : product.price.toDouble();
      return price.toDouble().toString();
    }

    double smallestPrice = double.infinity;
    double largestPrice = 0;

    for (var variation in product.productVariations!) {
      double priceToConsider =
          (variation.salePrice > 0.0) ? variation.salePrice : variation.price;

      if (priceToConsider < smallestPrice) {
        smallestPrice = priceToConsider;
      }
      if (priceToConsider > largestPrice) {
        largestPrice = priceToConsider;
      }
    }

    return smallestPrice == largestPrice
        ? largestPrice.toString()
        : '$smallestPrice - $largestPrice';
  }

  String? calculateProductDiscount(double originalPrice, double salePrice) {
    if (salePrice <= 0.0 || originalPrice <= 0.0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  String getPrroductStockStatus(int stock) {
    return stock > 0 ? 'In stock' : 'Out stock';
  }
}
