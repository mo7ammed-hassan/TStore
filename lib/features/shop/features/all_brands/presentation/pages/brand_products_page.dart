import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/t_appbar.dart';
import 'package:t_store/common/widgets/brands/brand_card.dart';
import 'package:t_store/common/widgets/products/sortable/sortable_dropdown.dart';
import 'package:t_store/common/widgets/products/sortable/sortable_products.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_products_grid_layout.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/all_brands/domain/entities/brand_entity.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/cubits/product_by_brand_cubit.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/cubits/product_by_brand_state.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_padding.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class BrandProductsPage extends StatelessWidget {
  const BrandProductsPage({super.key, required this.brand});

  final BrandEntity brand;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductsByBrandCubit()..fetchProductsByBrand(brandId: brand.id),
      child: Scaffold(
        appBar: const TAppBar(
          showBackArrow: true,
          title: 'Brand',
        ),
        body: SingleChildScrollView(
          child: ResponsivePadding.symmetric(
            horizontal: TSizes.spaceBtwItems,
            vertical: TSizes.defaultSpace / 2,
            child: Column(
              children: [
                TBrandCard(
                  brand: brand,
                  onTap: () {},
                ),
                ResponsiveGap.vertical(TSizes.spaceBtwSections),
                const TSectionHeading(
                  title: 'Products',
                  showActionButton: false,
                ),
                ResponsiveGap.vertical(TSizes.spaceBtwItems),
                BlocBuilder<ProductsByBrandCubit, ProductsByBrandState>(
                  builder: (context, state) {
                    if (state is ProductsByBrandLoadingState ||
                        state is ProductsByBrandInitialState) {
                      return _loadingProductList();
                    }

                    if (state is ProductsByBrandErrorState) {
                      return Center(
                        child: ResponsiveText(state.message),
                      );
                    }

                    if (state is ProductsByBrandLoadedState) {
                      if (state.products.isEmpty) {
                        return const Center(
                          child: ResponsiveText('No products found!'),
                        );
                      }
                      return TSortableProducts(
                        products: state.products,
                      );
                    }

                    return const Center(
                        child: ResponsiveText('Something went wrong!'));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadingProductList() {
    return Column(
      children: [
        const SortableDropdown(
          initialValue: 'Name',
        ),
        ResponsiveGap.vertical(TSizes.spaceBtwSections),
        const ShimmerProductsGridLayout(),
      ],
    );
  }
}
