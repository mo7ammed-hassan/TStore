import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TBottomNavigationBar extends StatelessWidget {
  const TBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  static const List<NavigationDestination> _destinations = [
    NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
    NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
    NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
    NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    
    return NavigationBar(
      height: 65,
      elevation: 0,
      selectedIndex: currentIndex,
      onDestinationSelected: onDestinationSelected,
      backgroundColor: isDark ? AppColors.black : AppColors.white,
      indicatorColor: isDark
          ? AppColors.white.withValues(alpha: 0.1)
          : AppColors.black.withValues(alpha: 0.1),
      destinations: _destinations,
    );
  }
}
