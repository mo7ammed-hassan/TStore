import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/custom_grid_view/products_grid_view.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_products_grid_layout.dart';
import 'package:t_store/features/navigation_menu/cubit/navigation_cubit.dart';
import 'package:t_store/features/shop/features/wishlist/presentation/pages/cubits/wishlist_cubit.dart';
import 'package:t_store/features/shop/features/wishlist/presentation/pages/cubits/wishlist_state.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/loaders/animation_loader.dart';

class BuildWishlistItems extends StatelessWidget {
  const BuildWishlistItems({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        if (state is WishlistLoading || state is WishlistInitial) {
          return const ShimmerProductsGridLayout(itemCount: 8);
        }

        if (state is WishlistLoaded) {
          if (state.wishlist.isEmpty) {
            return _buildAnimationWidget(context);
          }

          return ProductsGridView(
            products: state.wishlist,
          );
        }

        if (state is WishlistError) {
          return Center(child: Text(state.message));
        }

        return const Center(child: Text('Something went wrong!'));
      },
    );
  }

  Widget _buildAnimationWidget(BuildContext context) {
    return TAnimationLoaderWidget(
      text: 'Woops, Wishlist is empty',
      animation: TImages.pencilAnimation,
      showAction: true,
      actionText: 'Let\'s add more',
      onActionPressed: () => context.read<NavigationCubit>().goHome(),
    );
  }
}
