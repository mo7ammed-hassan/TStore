import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_attribute_entity.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/product_details/presentation/widgets/build_choice_chips.dart';
import 'package:t_store/features/shop/features/product_details/presentation/widgets/variation_details.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';

class TProductAttributes extends StatelessWidget {
  final ProductEntity product;
  const TProductAttributes({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VariationDetails(),
        ResponsiveGap.vertical(TSizes.spaceBtwItems),
        _buildAttributesList(context),
      ],
    );
  }

  // This method builds the list of attributes from the product
  Widget _buildAttributesList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: product.productAttributes.asMap().entries.map((attribute) {
        return _buildAttributeSection(context, attribute);
      }).toList(),
    );
  }

  // This method builds each individual attribute section
  Widget _buildAttributeSection(
      BuildContext context, MapEntry<int, ProductAttributeEntity> attribute) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (attribute.key.isOdd) ResponsiveGap.vertical(TSizes.spaceBtwItems),
        TSectionHeading(
          title: attribute.value.name,
          showActionButton: false,
        ),
        ResponsiveGap.vertical(TSizes.spaceBtwItems / 2),
        BuildChoiceChips(attribute: attribute, product: product),
      ],
    );
  }
}
