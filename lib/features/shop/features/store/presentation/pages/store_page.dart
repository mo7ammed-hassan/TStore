import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/pages/all_brands_page.dart';
import 'package:t_store/features/shop/features/cart/presentation/pages/cart_page.dart';
import 'package:t_store/features/shop/features/home/presentation/cubits/category/category_cubit.dart';
import 'package:t_store/features/shop/features/store/presentation/cubits/store_cubit.dart';
import 'package:t_store/features/shop/features/store/presentation/widgets/store_header.dart';
import 'package:t_store/features/shop/features/store/presentation/widgets/category_tab.dart';
import 'package:t_store/utils/helpers/navigation.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StoreCubit(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit()..getAllCategories(),
        ),
      ],
      child: Builder(builder: (context) {
        final categoryTabs = context
            .read<CategoryCubit>()
            .featuredCategories
            .map((category) => TCategoryTab(category: category))
            .toList();
        return DefaultTabController(
          length: context.read<CategoryCubit>().featuredCategories.length,
          child: SafeArea(
            child: Scaffold(
              appBar: _buildAppBar(context),
              body: NestedScrollView(
                headerSliverBuilder: (_, __) => [
                  StoreHeader(
                    onViewAllBrands: () =>
                        context.pushPage(const AllBrandsPage()),
                  ),
                ],
                body: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: categoryTabs,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  TAppBar _buildAppBar(BuildContext context) {
    return TAppBar(
      title: 'Store',
      actions: [
        TCartCounterIcon(
          onPressed: () => context.pushPage(const CartPage()),
        ),
      ],
    );
  }
}
