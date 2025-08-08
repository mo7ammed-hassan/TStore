import 'package:flutter/material.dart';
import 'package:t_store/features/personalization/pages/settings/presentation/pages/settings_page.dart';
import 'package:t_store/features/shop/features/home/presentation/pages/home_page.dart';
import 'package:t_store/features/shop/features/store/presentation/pages/store_page.dart';
import 'package:t_store/features/shop/features/wishlist/presentation/pages/wishlist_page.dart';

class NavigationScreenBody extends StatefulWidget {
  const NavigationScreenBody({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  State<NavigationScreenBody> createState() => _NavigationScreenBodyState();
}

class _NavigationScreenBodyState extends State<NavigationScreenBody> {
  final List<Widget Function()> _screenBuilders = [
    () => const HomePage(),
    () => const StorePage(),
    () => const WishlistPage(),
    () => const SettingsPage(),
  ];

  late final List<Widget?> _screens = List.filled(_screenBuilders.length, null);

  @override
  void initState() {
    super.initState();
    _loadScreen(widget.currentIndex);
  }

  @override
  void didUpdateWidget(covariant NavigationScreenBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _loadScreen(widget.currentIndex);
    }
  }

  void _loadScreen(int index) {
    _screens[index] ??= _screenBuilders[index]();
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: widget.currentIndex,
      children: List.generate(
        _screens.length,
        (index) => _screens[index] ?? const SizedBox(),
      ),
    );
  }
}
