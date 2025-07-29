import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/appbar/tabbar.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:t_store/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:t_store/features/shop/features/cart/presentation/pages/cart_page.dart';
import 'package:t_store/features/shop/features/home/presentation/cubits/category/category_cubit.dart';
import 'package:t_store/features/shop/features/store/presentation/widgets/category_tab.dart';
import 'package:t_store/features/shop/features/store/presentation/widgets/featured_brands_section.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryCubit().featuredCategories;
    final categoryTabs =
        categories.map((category) => Tab(child: Text(category.name))).toList();
    final categoryViews =
        categories.map((category) => TCategoryTab(category: category)).toList();
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: _storeAppBar(context),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: HelperFunctions.isDarkMode(context)
                    ? AppColors.black
                    : AppColors.white,
                expandedHeight: 420, //440
                flexibleSpace: const Padding(
                  padding: EdgeInsets.all(TSizes.defaultSpace),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: TSizes.spaceBtwItems),
                        TSearchConatiner(
                          text: 'Search in Store',
                          padding: EdgeInsets.zero,
                          showBackground: false,
                        ),
                        SizedBox(height: TSizes.spaceBtwItems),
                        FeaturedBrandsSection(),
                      ],
                    ),
                  ),
                ),

                // Tabs --
                bottom: TTabBar(
                  tabs: categoryTabs,
                ),
              ),
            ];
          },
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: categoryViews,
          ),
        ),
      ),
    );
  }

  TAppBar _storeAppBar(BuildContext context) {
    return TAppBar(
      title: Text('Store', style: Theme.of(context).textTheme.headlineMedium),
      actions: [
        TCartCounterIcon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
