import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/all_products/presentation/cubits/products_cubit.dart';
import 'package:t_store/features/shop/features/all_products/presentation/pages/all_products_page.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/featured_product_section.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/popular_products_section.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/home_header_section.dart';
import 'package:t_store/config/service_locator.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/slider/promo_slider.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/helpers/navigation.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/utils/responsive/widgets/responsive_padding.dart';

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
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Header (User Name, Search, Categories)
              const SliverToBoxAdapter(child: HomeHeaderSection()),

              const SliverToBoxAdapter(child: TPromoSlider()),

              // Featured Section Heading
              SliverToBoxAdapter(
                child: Padding(
                  padding: context.responsiveInsets.symmetric(
                    horizontal: TSizes.spaceBtwItems,
                  ),
                  child: TSectionHeading(
                    title: 'Featured Products',
                    onPressed: () {
                      context.pushPage(
                        const AllProductsPage(
                          title: 'Featured Products',
                          isFeatured: true,
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Featured Products Grid
              const FeaturedProductSection(),
              SliverToBoxAdapter(
                child: ResponsiveGap.vertical(TSizes.spaceBtwSections / 2),
              ),

              // Popular Section Heading
              SliverToBoxAdapter(
                child: ResponsivePadding.symmetric(
                  horizontal: TSizes.spaceBtwItems,
                  child: TSectionHeading(
                    title: 'Popular Products',
                    onPressed: () {
                      context.pushPage(
                        const AllProductsPage(
                          title: 'Popular Products',
                          isPopular: true,
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Popular Products Grid
              const PopularProductsSection(),

              SliverToBoxAdapter(
                child: ResponsiveGap.vertical(TSizes.spaceBtwSections),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
