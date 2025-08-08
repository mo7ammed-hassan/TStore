import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/navigation_menu/widgets/bottom_navigation_bar.dart';
import 'package:t_store/features/navigation_menu/widgets/navigation_screen_body.dart';
import 'package:t_store/features/personalization/cubit/user_cubit.dart';
import 'package:t_store/features/shop/features/cart/presentation/cubits/cart_cubit.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  final List<int> _navigationHistory = [0];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await Future.wait([
      context.read<UserCubit>().fetchUserData(),
      context.read<CartCubit>().fetchCartItems(),
    ], eagerError: true);
  }

  void _onItemTapped(int index) {
    if (_currentIndex == index) return;

    setState(() {
      _currentIndex = index;
      if (_navigationHistory.isEmpty || _navigationHistory.last != index) {
        _navigationHistory.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (_navigationHistory.isNotEmpty && !didPop) {
          setState(() {
            _navigationHistory.removeLast();
            _currentIndex = _navigationHistory.last;
          });
        }
      },
      child: Scaffold(
        bottomNavigationBar: TBottomNavigationBar(
          onDestinationSelected: _onItemTapped,
          currentIndex: _currentIndex,
        ),
        body: NavigationScreenBody(
          currentIndex: _currentIndex,
        ),
      ),
    );
  }
}
