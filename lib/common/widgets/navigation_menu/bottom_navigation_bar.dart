import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/cubits/navigation_menu_cubit.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TBottomNavigationBar extends StatelessWidget {
  const TBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return BlocBuilder<NavigationMenuCubit, int>(
      builder: (context, state) {
        return NavigationBar(
          height: 65,
          elevation: 0,
          selectedIndex: state,
          onDestinationSelected: context.read<NavigationMenuCubit>().setScreen,
          backgroundColor:
              isDark ? const Color.fromARGB(255, 15, 15, 15) : AppColors.white,
          indicatorColor: isDark
              ? AppColors.white.withValues(alpha: 0.1)
              : AppColors.black.withValues(alpha: 0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        );
      },
    );
  }
}
