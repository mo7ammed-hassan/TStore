import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:t_store/features/shop/features/all_products/data/mapper/product_mapper.dart';
import 'package:t_store/features/shop/features/all_products/data/models/product_model.dart';

class ShimmerProductsGridLayout extends StatelessWidget {
  final int itemCount;
  const ShimmerProductsGridLayout({super.key, this.itemCount = 4});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: TGridLayout(
        itemCount: itemCount,
        itemBuilder: (p0, p1) => TVerticalProductCard(
          product: ProductModel.empty().toEntity(),
        ),
      ),
    );
  }
}
