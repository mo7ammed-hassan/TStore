import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/texts/product_price.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_variation_entity.dart';
import 'package:t_store/features/shop/features/product_details/presentation/cubits/product_variation_cubit.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class VariationDetails extends StatelessWidget {
  const VariationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<ProductVariationCubit, ProductVariationEntity>(
      builder: (context, state) {
        if (state.id.isEmpty) return const SizedBox();

        return TRoundedContainer(
          padding: context.responsiveInsets.all(TSizes.md),
          backgroundColor: isDark ? AppColors.darkGrey : AppColors.grey,
          child: Column(
            children: [
              _buildVariationHeader(context, state),
              ResponsiveGap.vertical(TSizes.spaceBtwItems / 2),
              if (state.description != null && state.description!.isNotEmpty)
                _buildDescription(state.description!),
            ],
          ),
        );
      },
    );
  }

  // Builds the row for the variation price, stock, etc.
  Widget _buildVariationHeader(
      BuildContext context, ProductVariationEntity state) {
    final variationCubit = context.read<ProductVariationCubit>();
    final price = variationCubit.getVariationPrice();

    return Row(
      children: [
        const TSectionHeading(
          title: 'Variation',
          showActionButton: false,
        ),
        ResponsiveGap.horizontal(TSizes.spaceBtwSections),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPriceRow(
                context, price, state.salePrice > 0 ? state.price : null),
            _buildStockRow(context, variationCubit.variationStockState),
          ],
        ),
      ],
    );
  }

  // Builds the price row (with sale and original price if applicable)
  Widget _buildPriceRow(
      BuildContext context, String price, double? originalPrice) {
    return Row(
      children: [
        const TProductTitleText(
          title: 'Price:',
          smallSize: true,
        ),
        ResponsiveGap.horizontal(TSizes.spaceBtwItems),
        TProductPriceText(price: price),
        if (originalPrice != null)
          Row(
            children: [
              ResponsiveGap.horizontal(TSizes.spaceBtwItems),
              ResponsiveText(
                '\$${originalPrice.toString()}',
                style: Theme.of(context).textTheme.titleSmall!.apply(
                      decoration: TextDecoration.lineThrough,
                    ),
              ),
            ],
          ),
      ],
    );
  }

  // Builds the stock status row
  Widget _buildStockRow(BuildContext context, String stockStatus) {
    return Row(
      children: [
        const TProductTitleText(
          title: 'Stock:',
          smallSize: true,
        ),
        ResponsiveGap.horizontal(TSizes.spaceBtwItems),
        ResponsiveText(
          stockStatus,
          style:
              Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14),
        ),
      ],
    );
  }

  // Builds the product description
  Widget _buildDescription(String description) {
    return TProductTitleText(
      title: description,
      smallSize: true,
      maxLines: 4,
    );
  }
}
