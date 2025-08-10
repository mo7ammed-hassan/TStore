import 'package:flutter/material.dart';
import 'package:t_store/features/shop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/shop/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:t_store/utils/constants/sizes.dart';

class CartItemsList extends StatelessWidget {
  const CartItemsList(
      {super.key, required this.cartItems, required this.showAddRemoveButtons});
  final List<CartItemEntity> cartItems;
  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: cartItems.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => CartItemCard(
        key: ValueKey(cartItems[index].id),
        showAddRemoveButtons: showAddRemoveButtons,
        cartItem: cartItems[index],
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: TSizes.spaceBtwSections,
      ),
    );
  }
}
