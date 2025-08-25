import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/products/sortable/sortable_products.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_products_grid_layout.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/all_products/presentation/cubits/all_product_cubit.dart';
import 'package:t_store/features/shop/features/all_products/presentation/cubits/all_products_state.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_padding.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class AllProductsPage extends StatelessWidget {
  const AllProductsPage({
    super.key,
    this.products,
    required this.future,
    required this.title,
  });
  final List<ProductEntity>? products;
  final dynamic future;
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllProductsCubit()..fetchAllProducts(future: future),
      child: Scaffold(
        appBar: _appBar(context),
        body: SingleChildScrollView(
          child: ResponsivePadding.symmetric(
            horizontal: TSizes.spaceBtwItems,
            vertical: TSizes.defaultSpace,
            child: BlocBuilder<AllProductsCubit, AllProductsState>(
              builder: (context, state) {
                if (state is AllProductsLoadingState) {
                  return ShimmerProductsGridLayout();
                }
                if (state is AllProductsLoadedState) {
                  if (state.products!.isEmpty) {
                    return const Center(
                      child: ResponsiveText('No products found'),
                    );
                  }
                  return TSortableProducts(
                    products: state.products ?? products ?? [],
                  );
                }
                if (state is AllProductsFailureState) {
                  return Center(
                    child: ResponsiveText('Error: ${state.error}'),
                  );
                } else {
                  return const Center(
                      child: ResponsiveText('No products found.'));
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  TAppBar _appBar(BuildContext context) {
    return TAppBar(
      showBackArrow: true,
      title: ResponsiveText(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
      ),
      leadingOnPressed: () {
        AllProductsCubit().close();
      },
    );
  }
}
