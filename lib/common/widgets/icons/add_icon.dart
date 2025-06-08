import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_state.dart';
import 'package:t_store/features/shop/features/product_details/presentation/pages/product_detail_page.dart';
import 'package:t_store/service_locator.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/navigation.dart';

class AddIcon extends StatelessWidget {
  const AddIcon({super.key, this.onTap, required this.product});
  final Function()? onTap;
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    final cartCubit = getIt.get<CartCubit>();
    return BlocProvider.value(
      value: cartCubit,
      child: InkWell(
        onTap: () {
          if (product.productType == ProductType.single.toString()) {
            cartCubit.addProductToCartFormProduct(product: product);
          } else {
            context.pushPage(ProductDetailPage(product: product));
          }
        },
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            var cartItemQuantity =
                cartCubit.getItemQuantity(productId: product.id);
            return Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(AppSizes.productImageRadius),
                  topLeft: Radius.circular(AppSizes.productImageRadius),
                ),
                color:
                    cartItemQuantity > 0 ? AppColors.primary : AppColors.dark,
              ),
              child: SizedBox(
                width: AppSizes.iconLg * 1.2,
                height: AppSizes.iconLg * 1.2,
                child: Center(
                  child: cartItemQuantity > 0
                      ? Text(
                          (cartItemQuantity).toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .apply(color: AppColors.white),
                        )
                      : const Icon(
                          Iconsax.add,
                          color: AppColors.white,
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
