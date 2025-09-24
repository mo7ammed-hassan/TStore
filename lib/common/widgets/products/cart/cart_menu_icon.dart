import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/utils/responsive/responsive.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_state.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';

class TCartCounterIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? iconColor;
  const TCartCounterIcon({
    super.key,
    required this.onPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        IconButton(
          icon: Icon(
            Iconsax.shopping_bag,
            color: iconColor ?? (isDark ? AppColors.white : AppColors.black),
          ),
          onPressed: onPressed,
        ),
        Positioned(
          right: 0,
          child: Container(
            width: context.horzSize(17),
            height: context.horzSize(17),
            decoration: BoxDecoration(
              color: AppColors.black.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return ResponsiveText(
                    context.read<CartCubit>().getCartLength().toString(),
                    style: Theme.of(context).textTheme.bodySmall!.apply(
                          color: AppColors.white,
                          fontSizeFactor: 0.8,
                        ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
