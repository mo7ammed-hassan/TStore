import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:t_store/common/widgets/animated_widget/animated_fade_grid_item.dart';
import 'package:t_store/common/widgets/animated_widget/animated_grid_layout.dart';
import 'package:t_store/common/widgets/animation_containers/open_container_wrapper.dart';
import 'package:t_store/common/widgets/brands/brand_card.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/all_brands/domain/entities/brand_entity.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/cubits/brand_cubit.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/cubits/brand_state.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/pages/all_brands_page.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/pages/brand_products_page.dart';
import 'package:t_store/service_locator.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/navigation.dart';

class FeaturedBrandsSection extends StatelessWidget {
  const FeaturedBrandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final brandCubit = getIt.get<BrandCubit>();
    return BlocProvider(
      create: (context) => brandCubit
        ..fetchFeaturedBrands()
        ..fetchAllBrands(),
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSizes.sm),
        child: Column(
          children: [
            TSectionHeading(
              title: 'Future Brands',
              onPressed: () {
                context.pushPage(const AllBrandsPage());
              },
            ),
            const SizedBox(height: AppSizes.spaceBtwItems / 2),
            BlocBuilder<BrandCubit, BrandState>(
              builder: (context, state) {
                // Handle loading state
                if (state is BrandLoading || state is BrandInitial) {
                  return _loadingBrandsList();
                }

                // Handle error state
                if (state is BrandError) {
                  return Center(child: Text(state.featuredBrandsMessage!));
                }

                // Handle loaded state
                if (state is BrandLoaded) {
                  if (state.featuredBrands.isEmpty) {
                    return const Center(child: Text('No brands found!'));
                  }

                  return _buildBrandsListItems(state.featuredBrands);
                }

                // Handle unknown state
                return const Center(child: Text('Something went wrong!'));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandsListItems(List<BrandEntity> brands) {
    return AnimatedGridLayout(
      itemCount: brands.length,
      mainAxisExtent: 80,
      itemBuilder: (_, index) => OpenContainerWrapper(
        nextScreen: BrandProductsPage(
          brand: brands[index],
        ),
        radius: const Radius.circular(AppSizes.cardRadiusLg),
        child: TBrandCard(brand: brands[index]),
      ),
      animatedEffect: ({required child, isVisible, onAdd, onRemove}) {
        return AnimatedFadeGridItem(
          isVisible: isVisible!,
          onRemove: onRemove!,
          child: child,
        );
      },
    );
  }

  Widget _loadingBrandsList() {
    return Skeletonizer(
      child: _buildBrandsListItems(
        List.generate(
          4,
          (index) => BrandEntity.empty(),
        ),
      ),
    );
  }
}
