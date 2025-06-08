import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/all_products/domain/usecases/get_all_popular_products_use_case.dart';
import 'package:t_store/features/shop/features/all_products/domain/usecases/get_fetured_products_use_case.dart';
import 'package:t_store/features/shop/features/all_products/presentation/cubits/products_cubit.dart';
import 'package:t_store/features/shop/features/all_products/presentation/pages/all_products_page.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/featured_product_section.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/popular_products_section.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/slider/promo_slider.dart';
import 'package:t_store/service_locator.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/navigation.dart';

class HomeBodySection extends StatelessWidget {
  const HomeBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    final productsCubit = getIt.get<ProductsCubit>();
    return BlocProvider.value(
      value: productsCubit,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spaceBtwItems,
          vertical: AppSizes.defaultSpace,
        ),
        child: Column(
          children: [
            const TPromoSlider(),
            const SizedBox(height: AppSizes.spaceBtwSections),
            TSectionHeading(
              title: 'Featured Products',
              onPressed: () async {
                context.pushPage(
                  AllProductsPage(
                    title: 'Featured Products',
                    products: productsCubit.featuredProducts,
                    future: GetFeturedProductsUseCase().call(params: 10),
                  ),
                );
              },
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            const FeaturedProductSection(),
            const SizedBox(height: AppSizes.spaceBtwSections),
            TSectionHeading(
              title: 'Popular Products',
              onPressed: () {
                context.pushPage(
                  AllProductsPage(
                    title: 'Popular Products',
                    products: productsCubit.allProducts,
                    future: GetAllPopularProductsUseCase().call(params: 10),
                  ),
                );
              },
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            const PopularProductsSection(),
          ],
        ),
      ),
    );
  }
}
