import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_cart_items_list.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_state.dart';
import 'package:t_store/features/shop/features/cart/presentation/widgets/cart_items_list.dart';
import 'package:t_store/core/utils/constants/images_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class CartItemsSection extends StatelessWidget {
  const CartItemsSection({
    super.key,
    this.showAddRemoveButtons = true,
    this.sliverList = false,
  });

  final bool showAddRemoveButtons;
  final bool sliverList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (_, state) {
        if (state is CartLoadingState) {
          return ShimmerCartItemsList(
            sliverList: sliverList,
          );
        }

        if (state is CartErrorState) {
          return _buildMessage('Something went wrong 🥲');
        }

        if (state is CartLoadedState) {
          if (state.cartItems.isEmpty) {
            return _emptyCart(context);
          }

          return sliverList
              ? CartItemsList.sliver(state.cartItems, showAddRemoveButtons)
              : CartItemsList(
                  cartItems: state.cartItems,
                  showButtons: showAddRemoveButtons,
                );
        }

        return sliverList
            ? const SliverToBoxAdapter()
            : const SizedBox.shrink();
      },
    );
  }

  Widget _buildMessage(String message) {
    if (sliverList) {
      return SliverToBoxAdapter(
        child: Center(child: ResponsiveText(message)),
      );
    }
    return Center(
      child: ResponsiveText(
        message,
        fontSize: 13,
      ),
    );
  }

  Widget _emptyCart(BuildContext context) {
    return sliverList
        ? SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  width: context.horzSize(200),
                  child: LottieBuilder.asset(TImages.cartAnimation),
                ),
              ],
            ),
          )
        : Center(
            child: Column(
              children: [
                const Spacer(
                  flex: 1,
                ),
                Expanded(child: LottieBuilder.asset(TImages.cartAnimation)),
                ResponsiveGap.vertical(TSizes.spaceBtwItems * 2),
                _buildMessage('Oops! your cart is empty, let\'s fill it'),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          );
  }
}
