import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/icons/circular_icon.dart';
import 'package:t_store/features/shop/features/wishlist/presentation/pages/cubits/favorite_button_cubit.dart';
import 'package:t_store/features/shop/features/wishlist/presentation/pages/cubits/favorite_button_state.dart';
import 'package:t_store/service_locator.dart';
import 'package:t_store/utils/constants/colors.dart';

class FavoriteButton extends StatelessWidget {
  final String productId;

  const FavoriteButton({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<FavoriteButtonCubit>(),
      child: BlocConsumer<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          return TCircularIcon(
            onPressed: () async {
              await context
                  .read<FavoriteButtonCubit>()
                  .toggleWishlist(productId);
            },
            icon: Iconsax.heart5,
            color: context
                    .read<FavoriteButtonCubit>()
                    .checkProductInWishlist(productId)
                ? Colors.red
                : AppColors.grey,
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
