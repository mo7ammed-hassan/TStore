import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/custom_grid_view/products_grid_view.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_products_grid_layout.dart';
import 'package:t_store/features/shop/features/store/presentation/cubits/store_cubit.dart';
import 'package:t_store/features/shop/features/store/presentation/cubits/store_state.dart';

class ProductsSection extends StatefulWidget {
  final String categoryId;
  const ProductsSection({super.key, required this.categoryId});

  @override
  State<ProductsSection> createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<ProductsSection> {
  @override
  void initState() {
    super.initState();
    context
        .read<StoreCubit>()
        .fetchProductsSpecificCategory(categoryId: widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreCubit, StoreState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        if (state is StoreProductLoading) {
          return ShimmerProductsGridLayout.sliver(context);
        }

        if (state is StoreProductError) {
          return SliverToBoxAdapter(child: Center(child: Text(state.error)));
        }

        if (state is StoreProductLoaded) {
          if (state.products.isEmpty) {
            return const SliverToBoxAdapter(
              child: Center(child: Text('No products found!')),
            );
          }

          return ProductsGridView.sliver(context, state.products);
        }

        return const SliverToBoxAdapter(
          child: Center(child: Text('Something went wrong!')),
        );
      },
    );
  }

  bool _buildWhen(StoreState previous, current) =>
      current is StoreProductLoaded ||
      current is StoreProductError ||
      current is StoreProductLoading;
}
