import 'package:equatable/equatable.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';

// Explicit State Representation || Strongly Typed State
class ProductsState extends Equatable {
  final ProductsSubsetState popular;
  final ProductsSubsetState featured;

  const ProductsState({required this.popular, required this.featured});

  factory ProductsState.initial() => const ProductsState(
        popular: ProductsSubsetState.initial(),
        featured: ProductsSubsetState.initial(),
      );

  ProductsState copyWith({
    ProductsSubsetState? popular,
    ProductsSubsetState? featured,
  }) {
    return ProductsState(
      popular: popular ?? this.popular,
      featured: featured ?? this.featured,
    );
  }

  @override
  List<Object?> get props => [popular, featured];
}

class ProductsSubsetState extends Equatable {
  final List<ProductEntity> products;
  final bool isLoading;
  final String? error;

  const ProductsSubsetState({
    required this.products,
    required this.isLoading,
    required this.error,
  });

  const ProductsSubsetState.initial()
      : products = const [],
        isLoading = false,
        error = null;

  ProductsSubsetState copyWith({
    List<ProductEntity>? products,
    bool? isLoading,
    String? error,
  }) {
    return ProductsSubsetState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [products, isLoading, error];
}

// ------------------------------------------------------------------------------------------------//
// import 'package:equatable/equatable.dart';
// import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';

// class ProductSubsetState extends Equatable {
//   final bool loading;
//   final String? error;
//   final List<ProductEntity> items;

//   const ProductSubsetState({
//     this.loading = false,
//     this.error,
//     this.items = const [],
//   });

//   ProductSubsetState copyWith({
//     bool? loading,
//     String? error,
//     List<ProductEntity>? items,
//   }) {
//     return ProductSubsetState(
//       loading: loading ?? this.loading,
//       error: error,
//       items:
//           items != null ? List<ProductEntity>.unmodifiable(items) : this.items,
//     );
//   }

//   @override
//   List<Object?> get props => [loading, error, items];
// }

// enum ProductsCategory { popular, featured }
// // Map Based => Dynamic State Representation || Dictionary/Map Driven State
// class ProductsState extends Equatable {
//   final Map<ProductsCategory, ProductSubsetState> subsets;

//   const ProductsState({
//     this.subsets = const {
//       ProductsCategory.popular: ProductSubsetState(),
//       ProductsCategory.featured: ProductSubsetState(),
//     },
//   });
//   factory ProductsState.initial() => const ProductsState();

//   ProductSubsetState getSubset(ProductsCategory category) =>
//       subsets[category] ?? const ProductSubsetState();

//   ProductsState copyWith({
//     Map<ProductsCategory, ProductSubsetState>? subsets,
//   }) {
//     return ProductsState(subsets: subsets ?? this.subsets);
//   }

//   ProductsState updateSubset(
//     ProductsCategory category,
//     ProductSubsetState Function(ProductSubsetState current) reducer,
//   ) {
//     final current = getSubset(category);
//     final next = reducer(current);
//     return copyWith(
//       subsets: {
//         ...subsets,
//         category: next,
//       },
//     );
//   }

//   @override
//   List<Object?> get props => [subsets];
// }
