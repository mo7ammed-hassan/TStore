import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/products/product_cards/product_card_horizantal.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_sub_category_products.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/sub_category/presentation/cubits/sub_category_cubit.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class BuildSubCategoryProducts extends StatelessWidget {
  const BuildSubCategoryProducts({super.key, required this.subCategoryId});
  final String subCategoryId;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductEntity>>(
      future: context
          .read<SubCategoryCubit>()
          .fetchProductsSpecificCategory(categoryId: subCategoryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ShimmerSubCategoryProducts();
        }

        if (snapshot.hasError) {
          return Center(child: ResponsiveText(snapshot.error.toString()));
        }

        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Center(child: ResponsiveText('No products found'));
          }

          return _buildSubCategoryProducts(products: snapshot.data!);
        }

        return const Center(child: ResponsiveText('Something went wrong!'));
      },
    );
  }

  Widget _buildSubCategoryProducts({required List<ProductEntity> products}) {
    return ListView.separated(
      itemCount: products.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) =>
          ProductCardHorizantal(product: products[index]),
      separatorBuilder: (BuildContext context, int index) =>
          ResponsiveGap.horizontal(TSizes.spaceBtwItems),
    );
  }
}
