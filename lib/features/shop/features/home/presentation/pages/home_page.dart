import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/all_products/domain/usecases/get_all_popular_products_use_case.dart';
import 'package:t_store/features/shop/features/all_products/domain/usecases/get_fetured_products_use_case.dart';
import 'package:t_store/features/shop/features/all_products/presentation/cubits/products_cubit.dart';
import 'package:t_store/features/shop/features/all_products/presentation/pages/all_products_page.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/featured_product_section.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/popular_products_section.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/home_header_section.dart';
import 'package:t_store/service_locator.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/helpers/navigation.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ProductsCubit productsCubit;

  @override
  void initState() {
    super.initState();
    productsCubit = getIt.get<ProductsCubit>();
    productsCubit.fetchInitialData();
  }

  @override
  void dispose() {
    productsCubit.close();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    TFullScreenLoader.openLoadingDialog(
      'Loading data...',
      TImages.loadingJuggle,
    );

    await productsCubit.refreshProducts();

    TFullScreenLoader.stopLoading();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => productsCubit,
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: CustomScrollView(
            slivers: [
              // Header (User Name, Search, Categories)
              const SliverToBoxAdapter(child: HomeHeaderSection()),

              // Featured Section Heading
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.spaceBtwItems,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      TSectionHeading(
                        title: 'Featured Products',
                        onPressed: () {
                          context.pushPage(
                            AllProductsPage(
                              title: 'Featured Products',
                              products: productsCubit.featuredProducts,
                              future:
                                  GetFeturedProductsUseCase().call(params: 10),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                    ],
                  ),
                ),
              ),

              // Featured Products Grid
              const FeaturedProductSection(),

              const SliverToBoxAdapter(
                child: SizedBox(height: TSizes.spaceBtwSections),
              ),

              // Popular Section Heading
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.spaceBtwItems,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      TSectionHeading(
                        title: 'Popular Products',
                        onPressed: () {
                          context.pushPage(
                            AllProductsPage(
                              title: 'Popular Products',
                              products: productsCubit.allProducts,
                              future: GetAllPopularProductsUseCase()
                                  .call(params: 10),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                    ],
                  ),
                ),
              ),

              // Popular Products Grid
              const PopularProductsSection(),

              const SliverToBoxAdapter(
                child: SizedBox(height: TSizes.spaceBtwSections),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
