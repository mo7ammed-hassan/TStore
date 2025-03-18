import 'package:t_store/features/shop/features/all_products/data/models/product_model.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_variation_entity.dart';
import 'package:t_store/features/shop/features/cart/data/models/cart_item_model.dart';
import 'package:t_store/features/shop/features/product_details/presentation/cubits/product_variation_cubit.dart';

// --Define an Abstract Factory--
abstract class CartItemFactoryInterface {
  CartItemModel createCartItem(
      {required ProductEntity product, required int quantity});
  void resetVariationCubit();
}

// --DIP >> Dependency Inversion Principle Applied with Factory Method Pattern
// --Implement a Concrete Factory.
// --We can use DI 'Loose Coupling' to inject the Cubit instead of directly using it.
// --This makes the class more testable and reusable.
// --Separation of Concerns.

class DefaultCartItemFactory implements CartItemFactoryInterface {
  final ProductVariationCubit variationCubit;

  // Inject Cubit >> making the class more testable and reusable.
  DefaultCartItemFactory(this.variationCubit);

  @override
  CartItemModel createCartItem({
    required ProductEntity product,
    required int quantity,
  }) {
    final selectedVariation = variationCubit.selectedVariation;
    final isVariationSelected = selectedVariation.id.isNotEmpty;

    // Get price based on selected variation or product price
    final price =
        _calculatePrice(product, isVariationSelected, selectedVariation);

    return CartItemModel(
      productId: product.id,
      title: product.title,
      imageUrl:
          isVariationSelected ? selectedVariation.image : product.thumbnail,
      quantity: quantity,
      price: price,
      brandName: product.brand != null ? product.brand!.name : '',
      variationId: selectedVariation.id,
      selectedVariation:
          isVariationSelected ? selectedVariation.attributeValues : null,
    );
  }

  // Extracted method for price calculation
  double _calculatePrice(
    ProductEntity product,
    bool isVariationSelected,
    ProductVariationEntity selectedVariation,
  ) {
    if (isVariationSelected) {
      return selectedVariation.salePrice > 0.0
          ? selectedVariation.salePrice
          : selectedVariation.price;
    }

    return (product.salePrice! > 0.0 ? product.salePrice : product.price)!
        .toDouble();
  }

  // --ResetVariationCubit
  @override
  void resetVariationCubit() {
    variationCubit.resetVariation();
  }
}

// DIP >> Dependency Inversion Principle Applied with DI Dependency Injection
class CartItemFactory {
  static CartItemModel fromProduct({
    required ProductModel product,
    required int quantity,
    required ProductVariationCubit
        variationCubit, // Inject instead of direct dependency 'DI'
  }) {
    final selectedVariation = variationCubit.selectedVariation;
    final isVariationSelected = selectedVariation.id.isNotEmpty;

    // Get price based on selected variation or product price
    final price =
        _calculatePrice(product, isVariationSelected, selectedVariation);

    return CartItemModel(
      productId: product.id,
      title: product.title,
      imageUrl:
          isVariationSelected ? selectedVariation.image : product.thumbnail,
      quantity: quantity,
      price: price,
      brandName: product.brand != null ? product.brand!.name : '',
      variationId: selectedVariation.id,
      selectedVariation:
          isVariationSelected ? selectedVariation.attributeValues : null,
    );
  }

  // Extracted method for price calculation
  static double _calculatePrice(
    ProductModel product,
    bool isVariationSelected,
    ProductVariationEntity selectedVariation,
  ) {
    if (isVariationSelected) {
      return selectedVariation.salePrice > 0.0
          ? selectedVariation.salePrice
          : selectedVariation.price;
    }

    return (product.salePrice > 0.0 ? product.salePrice : product.price)
        .toDouble();
  }
}
