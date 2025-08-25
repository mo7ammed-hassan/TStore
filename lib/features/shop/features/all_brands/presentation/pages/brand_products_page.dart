import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/brands/brand_card.dart';
import 'package:t_store/common/widgets/products/sortable/sortable_dropdown.dart';
import 'package:t_store/common/widgets/products/sortable/sortable_products.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_products_grid_layout.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/all_brands/domain/entities/brand_entity.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/cubits/product_by_brand_cubit.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/cubits/product_by_brand_state.dart';
import 'package:t_store/utils/constants/sizes.dart';

class BrandProductsPage extends StatelessWidget {
  const BrandProductsPage({super.key, required this.brand});

  final BrandEntity brand;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductsByBrandCubit()..fetchProductsByBrand(brandId: brand.id),
      child: Scaffold(
        appBar: _appBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: TSizes.spaceBtwItems,
              vertical: TSizes.defaultSpace,
            ),
            child: Column(
              children: [
                TBrandCard(brand: brand),
                const SizedBox(height: TSizes.spaceBtwSections),
                const TSectionHeading(
                  title: 'Products',
                  showActionButton: false,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                BlocBuilder<ProductsByBrandCubit, ProductsByBrandState>(
                  builder: (context, state) {
                    if (state is ProductsByBrandLoadingState ||
                        state is ProductsByBrandInitialState) {
                      return _loadingProductList();
                    }

                    if (state is ProductsByBrandErrorState) {
                      return Center(
                        child: Text(state.message),
                      );
                    }

                    if (state is ProductsByBrandLoadedState) {
                      if (state.products.isEmpty) {
                        return const Center(child: Text('No products found!'));
                      }
                      return TSortableProducts(
                        products: state.products,
                      );
                    }

                    return const Center(child: Text('Something went wrong!'));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TAppBar _appBar(BuildContext context) {
    return TAppBar(
      showBackArrow: true,
      title: Text(
        'Brand',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
      ),
    );
  }

  Widget _loadingProductList() {
    return const Column(
      children: [
        SortableDropdown(
          initialValue: 'Name',
        ),
        SizedBox(height: TSizes.spaceBtwSections),
        ShimmerProductsGridLayout(),
      ],
    );
  }
}
