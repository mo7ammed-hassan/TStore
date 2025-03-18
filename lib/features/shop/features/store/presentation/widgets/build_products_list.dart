import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/products/product_cards/vertical_product_card.dart';
import 'package:t_store/features/shop/features/all_products/data/models/product_model.dart';
import 'package:t_store/features/shop/features/store/presentation/cubits/store_cubit.dart';
import 'package:t_store/features/shop/features/store/presentation/cubits/store_state.dart';

class BuildProductsList extends StatelessWidget {
  final String categoryId;
  const BuildProductsList({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    context
        .read<StoreCubit>()
        .fetchProductsSpecificCategory(categoryId: categoryId);
    return BlocBuilder<StoreCubit, StoreState>(
      buildWhen: (previous, current) {
        if (current is StoreProductLoaded ||
            current is StoreProductError ||
            current is StoreProductLoading) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is StoreProductLoading) {
          return _loadingProductsList();
        }

        if (state is StoreProductError) {
          return Center(child: Text(state.error));
        }

        if (state is StoreProductLoaded) {
          if (state.products.isEmpty) {
            return const Center(child: Text('No products found!'));
          }
          return TGridLayout(
            itemCount: state.products.length,
            itemBuilder: (_, index) => TVerticalProductCard(
              product: state.products[index],
            ),
          );
        }

        return const Center(child: Text('Something went wrong!'));
      },
    );
  }

  Widget _loadingProductsList() {
    return Skeletonizer(
      child: TGridLayout(
        itemCount: 4,
        itemBuilder: (_, index) => TVerticalProductCard(
          product: ProductModel.empty().toEntity(),
        ),
      ),
    );
  }
}
