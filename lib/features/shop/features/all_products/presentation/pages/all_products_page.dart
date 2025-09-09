import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/products/sortable/sortable_products.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_products_grid_layout.dart';
import 'package:t_store/core/config/service_locator.dart';
import 'package:t_store/features/shop/features/all_products/presentation/cubits/all_product_cubit.dart';
import 'package:t_store/features/shop/features/all_products/presentation/cubits/all_products_state.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class AllProductsPage extends StatelessWidget {
  final String title;
  final String? categoryId;
  final String? brandId;
  final bool? isFeatured;
  final bool? isPopular;

  const AllProductsPage({
    super.key,
    required this.title,
    this.categoryId,
    this.brandId,
    this.isFeatured,
    this.isPopular,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AllProductsCubit>()
        ..fetchAllProducts(
          categoryId: categoryId,
          brandId: brandId,
          isFeatured: isFeatured,
          isPopular: isPopular,
        ),
      child: Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: title,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Iconsax.search_normal,
                size: context.horzSize(22),
              ),
            )
          ],
        ),
        body: Padding(
          padding: context.responsiveInsets.symmetric(
            horizontal: TSizes.spaceBtwItems,
            vertical: TSizes.defaultSpace / 2,
          ),
          child: BlocBuilder<AllProductsCubit, AllProductsState>(
            builder: (context, state) {
              if (state is AllProductsLoadingState) {
                return const ShimmerProductsGridLayout();
              }
              if (state is AllProductsLoadedState) {
                if (state.products?.isEmpty == true) {
                  return const Center(
                    child: ResponsiveText('No products found'),
                  );
                }
                return TSortableProducts(products: state.products ?? []);
              }
              if (state is AllProductsFailureState) {
                return Center(child: ResponsiveText('Error: ${state.error}'));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
