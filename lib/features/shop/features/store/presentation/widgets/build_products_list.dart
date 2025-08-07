import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:t_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:t_store/features/shop/features/all_products/data/mapper/product_mapper.dart';
import 'package:t_store/features/shop/features/all_products/data/models/product_model.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/store/presentation/cubits/store_cubit.dart';
import 'package:t_store/features/shop/features/store/presentation/cubits/store_state.dart';
import 'package:t_store/utils/constants/sizes.dart';

class BuildProductsList extends StatelessWidget {
  final String categoryId;
  const BuildProductsList({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    context
        .read<StoreCubit>()
        .fetchProductsSpecificCategory(categoryId: categoryId);

    return BlocBuilder<StoreCubit, StoreState>(
      buildWhen: (previous, current) =>
          current is StoreProductLoaded ||
          current is StoreProductError ||
          current is StoreProductLoading,
      builder: (context, state) {
        if (state is StoreProductLoading) {
          return _loadingProductsList();
        }

        if (state is StoreProductError) {
          return SliverToBoxAdapter(child: Center(child: Text(state.error)));
        }

        if (state is StoreProductLoaded) {
          if (state.products.isEmpty) {
            return const SliverToBoxAdapter(
                child: Center(child: Text('No products found!')));
          }

          return _buildProductsGrid(state.products);
        }

        return const SliverToBoxAdapter(
            child: Center(child: Text('Something went wrong!')));
      },
    );
  }

  /// Loading skeleton as Sliver
  Widget _loadingProductsList() {
    return SliverToBoxAdapter(
      child: Skeletonizer(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: TSizes.gridViewSpacing,
            crossAxisSpacing: TSizes.gridViewSpacing,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (_, index) => TVerticalProductCard(
            product: ProductModel.empty().toEntity(),
          ),
        ),
      ),
    );
  }

  Widget _buildProductsGrid(List<ProductEntity> products) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) => TVerticalProductCard(product: products[index]),
        childCount: products.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: TSizes.gridViewSpacing,
        crossAxisSpacing: TSizes.gridViewSpacing,
        childAspectRatio: 0.65,
      ),
    );
  }
}
