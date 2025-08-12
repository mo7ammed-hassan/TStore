import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_state.dart';
import 'package:t_store/features/shop/features/product_details/presentation/pages/product_detail_page.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TAddIcon extends StatelessWidget {
  const TAddIcon({super.key, this.onTap, required this.product});
  final Function()? onTap;
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final itemQuantity =
        context.read<CartCubit>().getItemQuantity(itemId: product.id);
    return GestureDetector(
      onTap: itemQuantity > 0
          ? () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 400),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return ProductDetailPage(product: product);
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            }
          : () async {
              await cartCubit.addItemToCart(
                showMessage: true,
                product: product,
                selectedVariation: product.productVariations!.first,
              );
            },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(TSizes.productImageRadius),
            topLeft: Radius.circular(TSizes.productImageRadius),
          ),
          color: AppColors.dark,
        ),
        child: SizedBox(
          width: TSizes.iconLg * 1.2,
          height: TSizes.iconLg * 1.2,
          child: Center(
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                final itemQuantity = context
                    .read<CartCubit>()
                    .getItemQuantity(itemId: product.id);
                return itemQuantity >= 1
                    ? Text(
                        itemQuantity.toString(),
                        style: TextStyle(color: AppColors.white),
                      )
                    : Icon(
                        Iconsax.add,
                        color: AppColors.white,
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
