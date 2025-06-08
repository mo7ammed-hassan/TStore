import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_variation_entity.dart';

class ProductVariationCubit extends Cubit<ProductVariationEntity> {
  ProductVariationCubit() : super(ProductVariationEntity.empty());

  // Store selected attributes
  Map<String, dynamic> selectedAttributes = {};

  // The selected variation
  ProductVariationEntity selectedVariation = ProductVariationEntity.empty();

  // Store the selected image
  String selectedIamge = '';

  // Stock state
  String variationStockState = '';

  // Initialize with the default variation
  void initializeWithDefault(ProductEntity product) {
    if (product.productVariations != null &&
        product.productVariations!.isNotEmpty) {
      // Set the default variation (first one or based on logic)
      selectedVariation = product.productVariations!.first;
      selectedIamge = selectedVariation.image;

      // Initialize selected attributes with default variation's attributes
      selectedAttributes =
          Map<String, dynamic>.from(selectedVariation.attributeValues);

      // Get stock state and emit
      getProductVariationStock();

      emit(selectedVariation);
    }
  }

  // Handle selection of an attribute
  void onSelectedAttribute(
      ProductEntity product, String attribute, String value) {
    selectedAttributes[attribute] = value;

    // Find the variation that matches the selected attributes
    final selectedVariation = product.productVariations!.firstWhere(
      (variation) =>
          _isSameAttributeValues(variation.attributeValues, selectedAttributes),
      orElse: () => ProductVariationEntity.empty(),
    );

    if (selectedVariation.image.isNotEmpty) {
      selectedIamge = selectedVariation.image;
    }

    this.selectedVariation = selectedVariation;
    getProductVariationStock();
    emit(this.selectedVariation);
  }

  // Check if selected attributes match the variation attributes
  bool _isSameAttributeValues(Map<String, dynamic> variationAttributes,
      Map<String, dynamic> selectedAttributes) {
    if (variationAttributes.length != selectedAttributes.length) return false;

    for (var key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }

    return true;
  }

  // Get the stock state of the selected variation
  void getProductVariationStock() {
    variationStockState =
        selectedVariation.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

// Get the price of the selected variation
  String getVariationPrice() {
    return (selectedVariation.salePrice > 0
            ? selectedVariation.salePrice
            : selectedVariation.price)
        .toString();
  }

  // Get available attribute values for the variation based on stock
  Set<String?> getAttributesAvailityInVariation(
      List<ProductVariationEntity> variations, String attribute) {
    final availableVariationAttributesValues = variations
        .where((variation) =>
            variation.attributeValues[attribute] != null &&
            variation.attributeValues[attribute]!.isNotEmpty &&
            variation.stock > 0)
        .map((variation) => variation.attributeValues[attribute])
        .toSet();

    return availableVariationAttributesValues;
  }

  // -- reset variation--
  void resetVariation() {
    selectedVariation = ProductVariationEntity.empty();
    selectedAttributes = {};
    selectedIamge = '';
    variationStockState = '';
    emit(selectedVariation);
  }
}
