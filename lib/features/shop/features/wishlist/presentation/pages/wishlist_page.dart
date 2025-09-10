import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/icons/circular_icon.dart';
import 'package:t_store/features/navigation_menu/cubit/navigation_cubit.dart';
import 'package:t_store/features/shop/features/wishlist/presentation/pages/cubits/wishlist_cubit.dart';
import 'package:t_store/features/shop/features/wishlist/presentation/wisgtes/wishlist_page_body.dart';
import 'package:t_store/core/config/service_locator.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<WishlistCubit>()..fetchWishlist(),
      child: SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: const WishlistPageBody(),
        ),
      ),
    );
  }

  TAppBar _buildAppBar(BuildContext context) {
    return TAppBar(
      title: 'Wishlist',
      actions: [
        TCircularIcon(
          icon: Iconsax.add,
          size: context.horzSize(22),
          onPressed: () {
            context.read<NavigationCubit>().goHome();
          },
        )
      ],
    );
  }
}
