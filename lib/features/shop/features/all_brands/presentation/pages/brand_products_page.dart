import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/brands/brand_card.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/products/product_cards/vertical_product_card.dart';
import 'package:t_store/common/widgets/products/sortable/sortable_dropdown.dart';
import 'package:t_store/common/widgets/products/sortable/sortable_products.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/all_brands/domain/entities/brand_entity.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/cubits/product_by_brand_cubit.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/cubits/product_by_brand_state.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
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
              horizontal: AppSizes.spaceBtwItems,
              vertical: AppSizes.defaultSpace,
            ),
            child: Column(
              children: [
                TBrandCard(brand: brand),
                const SizedBox(height: AppSizes.spaceBtwSections),
                const TSectionHeading(
                    title: 'Products', showActionButton: false),
                const SizedBox(height: AppSizes.spaceBtwItems),
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
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  Widget _loadingProductList() {
    return Column(
      children: [
        const SortableDropdown(
          initialValue: 'Name',
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),
        Skeletonizer(
          child: TGridLayout(
            itemCount: 6,
            itemBuilder: (context, index) => const TVerticalProductCard(
              product: ProductEntity.empty(),
            ),
          ),
        ),
      ],
    );
  }
}
