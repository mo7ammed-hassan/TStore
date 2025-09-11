import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/custom_grid_view/products_grid_view.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_products_grid_layout.dart';
import 'package:t_store/features/shop/features/all_products/presentation/cubits/products_cubit.dart';
import 'package:t_store/features/shop/features/all_products/presentation/cubits/products_state.dart';
import 'package:t_store/core/utils/constants/sizes.dart';

class PopularProductsSection extends StatelessWidget {
  const PopularProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductsCubit, ProductsState, ProductsSubsetState>(
      selector: (state) => state.popular,
      builder: (context, popularState) {
        if (popularState.isLoading) {
          return SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems),
            sliver: ShimmerProductsGridLayout.sliver(context),
          );
        }

        if (popularState.error != null) {
          return _errorSliver(popularState.error ?? 'There was an error');
        }

        if (popularState.products.isEmpty) {
          return _errorSliver('No product found.');
        }

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems),
          sliver: ProductsGridView.sliver(context, popularState.products),
        );
      },
    );
  }

  SliverToBoxAdapter _errorSliver(String errorMessage) {
    return SliverToBoxAdapter(
      key: const Key('popular_products_error'),
      child: Center(
        child: Text(errorMessage),
      ),
    );
  }
}
