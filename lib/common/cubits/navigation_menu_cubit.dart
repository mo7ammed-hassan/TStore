import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/personalization/pages/settings/presentation/pages/settings_page.dart';
import 'package:t_store/features/shop/features/home/presentation/pages/home_page.dart';
import 'package:t_store/features/shop/features/store/presentation/pages/store_page.dart';
import 'package:t_store/features/shop/features/wishlist/presentation/pages/wishlist_page.dart';

class NavigationMenuCubit extends Cubit<int> {
  NavigationMenuCubit() : super(0);

  final List<Widget> screens = [
    const HomePage(),
    const StorePage(),
    const WishlistPage(),
    const SettingsPage(),
  ];

  void setScreen(int index) => emit(index);
}
