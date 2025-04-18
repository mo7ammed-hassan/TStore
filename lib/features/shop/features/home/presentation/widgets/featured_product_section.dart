import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/animated_widget/animated_fade_grid_item.dart';
import 'package:t_store/common/widgets/animated_widget/animated_grid_layout.dart';
import 'package:t_store/common/widgets/products/product_cards/vertical_product_card.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_products_grid_layout.dart';
import 'package:t_store/features/shop/features/all_products/presentation/cubits/products_cubit.dart';
import 'package:t_store/features/shop/features/all_products/presentation/cubits/products_state.dart';

class FeaturedProductSection extends StatelessWidget {
  const FeaturedProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductsCubit>().fetchFeaturedProducts();
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoadingState || state is ProductsInitialState) {
          return const ShimmerProductsGridLayout();
        }
        if (state is ProductsFailureState) {
          return _errorWidget(state.featuredProductsError!);
        } else if (state is ProductsLoadedState) {
          if (state.featuredProducts.isEmpty) {
            return const Center(child: Text('No products found!'));
          }

          return AnimatedGridLayout(
            itemCount: state.featuredProducts.length,
            itemBuilder: (context, index) => TVerticalProductCard(
              product: state.featuredProducts[index],
            ),
            animatedEffect: ({required child, isVisible, onAdd, onRemove}) {
              return AnimatedFadeGridItem(
                isVisible: isVisible!,
                onRemove: onRemove!,
                duration: const Duration(milliseconds: 250),
                child: child,
              );
            },
          );
        }

        return const Center(child: Text('Something went wrong!'));
      },
    );
  }

  Widget _errorWidget(String errorMessage) {
    return Center(
      child: Text(errorMessage),
    );
  }
}
