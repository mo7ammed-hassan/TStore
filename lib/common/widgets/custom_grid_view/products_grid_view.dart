import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';

class ProductsGridView extends StatelessWidget {
  final List<ProductEntity> products;
  final bool useSliver;

  const ProductsGridView({
    super.key,
    required this.products,
    this.useSliver = false,
  });

  static Widget sliver(BuildContext context, List<ProductEntity> products) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final product = products[index];
          return _AnimatedGridItem(
            index: index,
            child: TVerticalProductCard(product: product),
          );
        },
        childCount: products.length,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: context.horzSize(50) / context.vertSize(86),
        mainAxisSpacing: context.vertSize(TSizes.gridViewSpacing),
        crossAxisSpacing: context.horzSize(TSizes.gridViewSpacing),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (useSliver) {
      return ProductsGridView.sliver(context, products);
    }

    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: context.horzSize(50) / context.vertSize(86),
        mainAxisSpacing: context.vertSize(TSizes.gridViewSpacing),
        crossAxisSpacing: context.horzSize(TSizes.gridViewSpacing),
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return _AnimatedGridItem(
          index: index,
          child: TVerticalProductCard(product: product),
        );
      },
      itemCount: products.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}

class _AnimatedGridItem extends StatelessWidget {
  final int index;
  final Widget child;

  const _AnimatedGridItem({required this.index, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
