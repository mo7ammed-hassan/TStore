import 'package:flutter/material.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/shop/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';

class CartItemsList extends StatelessWidget {
  const CartItemsList({
    super.key,
    required this.cartItems,
    required this.showButtons,
  });

  final List<CartItemEntity> cartItems;
  final bool showButtons;

  /// Sliver builder
  static Widget sliver(List<CartItemEntity> items, bool showButtons) {
    return SliverList.separated(
      itemCount: items.length,
      itemBuilder: (_, index) => CartItemCard(
        key: ValueKey(items[index].id),
        showAddRemoveButtons: showButtons,
        cartItem: items[index],
      ),
      separatorBuilder: (_, __) =>
          ResponsiveGap.vertical(TSizes.spaceBtwSections),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: cartItems.length,
      itemBuilder: (_, index) => CartItemCard(
        key: ValueKey(cartItems[index].id),
        showAddRemoveButtons: showButtons,
        cartItem: cartItems[index],
      ),
      separatorBuilder: (_, __) =>
          ResponsiveGap.vertical(TSizes.spaceBtwSections),
    );
  }
}
