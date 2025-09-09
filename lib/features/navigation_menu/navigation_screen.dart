import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/navigation_menu/cubit/navigation_cubit.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          return PopScope(
            canPop: !context.read<NavigationCubit>().canPop(),
            onPopInvokedWithResult: (didPop, result) {
              if (!didPop && context.read<NavigationCubit>().canPop()) {
                context.read<NavigationCubit>().popTab();
              }
            },
            child: Scaffold(
              bottomNavigationBar: TBottomNavigationBar(
                onDestinationSelected: (index) =>
                    context.read<NavigationCubit>().changeTab(index),
                currentIndex: currentIndex,
              ),
              body: NavigationScreenBody(
                currentIndex: currentIndex,
              ),
            ),
          );
        },
      ),
    );
  }
}
