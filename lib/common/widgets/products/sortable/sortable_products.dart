import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/animated_widget/animated_grid_layout.dart';
import 'package:t_store/common/widgets/animated_widget/animated_offset_grid_item.dart';
import 'package:t_store/common/widgets/products/product_cards/vertical_product_card.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/all_products/presentation/cubits/sortable_product_cubit.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';

import 'package:t_store/common/widgets/products/sortable/sortable_dropdown.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({super.key, required this.products});
  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SortableProductCubit()
        ..resetProducts(products)
        ..sortProducts('Name'),
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              SortableDropdown(
                initialValue: context.read<SortableProductCubit>().sortOption,
                onChanged: (value) => context
                    .read<SortableProductCubit>()
                    .sortProducts(value.toString()),
              ),
              ResponsiveGap.vertical(TSizes.spaceBtwSections),
              BlocBuilder<SortableProductCubit, List<ProductEntity>>(
                builder: (context, state) {
                  return AnimatedGridLayout(
                    itemCount: state.length,
                    itemBuilder: (context, index) => TVerticalProductCard(
                      product: state[index],
                    ),
                    animatedEffect: ({
                      required child,
                      isVisible,
                      onAdd,
                      onRemove,
                    }) {
                      return AnimatedOffsetGridItem(
                        isVisible: isVisible!,
                        onRemove: onRemove!,
                        child: child,
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
