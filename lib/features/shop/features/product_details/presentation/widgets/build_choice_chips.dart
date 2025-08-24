import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/choice_chip/choice_chip.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_attribute_entity.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_variation_entity.dart';
import 'package:t_store/features/shop/features/product_details/presentation/cubits/images_product_cubit.dart';
import 'package:t_store/features/shop/features/product_details/presentation/cubits/product_variation_cubit.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';

class BuildChoiceChips extends StatelessWidget {
  const BuildChoiceChips(
      {super.key, required this.attribute, required this.product});
  final MapEntry<int, ProductAttributeEntity> attribute;
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductVariationCubit, ProductVariationEntity>(
      builder: (context, state) {
        return Wrap(
          spacing: context.horzSize(8),
          children: attribute.value.values.map((attributeValue) {
            final available = _isAttributeAvailableInVariation(
                context, attribute.value.name, attributeValue);

            return TChoiceChip(
              text: attributeValue,
              selected: context
                      .read<ProductVariationCubit>()
                      .selectedAttributes[attribute.value.name] ==
                  attributeValue,
              onSelected: available
                  ? (selected) {
                      if (selected) {
                        _onAttributeSelected(
                            context, attribute, attributeValue);
                      }
                    }
                  : null,
            );
          }).toList(),
        );
      },
    );
  }

  // Check if the attribute value is available in variations
  bool _isAttributeAvailableInVariation(
      BuildContext context, String attributeName, String attributeValue) {
    return context
        .read<ProductVariationCubit>()
        .getAttributesAvailityInVariation(
            product.productVariations!, attributeName)
        .contains(attributeValue);
  }

  // Handle selection of an attribute
  void _onAttributeSelected(BuildContext context,
      MapEntry<int, ProductAttributeEntity> attribute, String attributeValue) {
    context
        .read<ProductVariationCubit>()
        .onSelectedAttribute(product, attribute.value.name, attributeValue);

    // Update selected image
    context.read<ImagesProductCubit>().selectImage(
          context.read<ProductVariationCubit>().selectedIamge,
        );
  }
}
