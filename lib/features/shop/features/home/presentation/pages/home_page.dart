import 'package:flutter/material.dart';
import 'package:t_store/features/shop/features/all_products/presentation/cubits/products_cubit.dart';
import 'package:t_store/features/shop/features/home/presentation/cubits/category/category_cubit.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/home_body_section.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/home_header_section.dart';
import 'package:t_store/service_locator.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: const SingleChildScrollView(
          child: Column(
            children: [
              HomeHeaderSection(),
              HomeBodySection(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    final productsCubit = getIt.get<ProductsCubit>();
    final categoryCubit = getIt.get<CategoryCubit>();

    TFullScreenLoader.openLoadingDialog(
      'Loading data...',
      TImages.loadingJuggle,
    );

    await productsCubit.refreshProducts();
    await categoryCubit.refreshCategories();

    TFullScreenLoader.stopLoading();
  }
}
