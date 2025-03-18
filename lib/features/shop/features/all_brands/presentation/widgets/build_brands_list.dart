import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:t_store/common/widgets/animated_widget/animated_grid_layout.dart';
import 'package:t_store/common/widgets/animated_widget/animated_offset_grid_item.dart';
import 'package:t_store/common/widgets/animation_containers/open_container_wrapper.dart';
import 'package:t_store/common/widgets/brands/brand_card.dart';
import 'package:t_store/features/shop/features/all_brands/domain/entities/brand_entity.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/cubits/brand_cubit.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/cubits/brand_state.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/pages/brand_products_page.dart';
import 'package:t_store/service_locator.dart';
import 'package:t_store/utils/constants/sizes.dart';

class BuildBrandsList extends StatelessWidget {
  const BuildBrandsList({super.key});

  @override
  Widget build(BuildContext context) {
    final brandCubit = getIt.get<BrandCubit>();

    return brandCubit.state is BrandLoaded
        ? brandCubit.allBrands.isEmpty
            ? const Center(child: Text('No brands found!'))
            : _buildBrandsListItems(brandCubit.allBrands)
        : brandCubit.state is BrandLoading
            ? _loadingBrandsList()
            : brandCubit.state is BrandError
                ? const Center(child: Text('There was an error!'))
                : const Center(child: Text('Something went wrong!'));

    // return BlocBuilder<BrandCubit, BrandState>(
    //   builder: (context, state) {
    //     if (state is BrandLoading) {
    //       return _loadingBrandsList();
    //     }

    //     if (state is BrandError) {
    //       return Center(child: Text(state.allBrandsMessage!));
    //     }

    //     if (state is BrandLoaded) {
    //       if (state.allbrands.isEmpty) {
    //         return const Center(child: Text('No brands found!'));
    //       }

    //       return _buildBrandsListItems(getIt.get<BrandCubit>().allBrands);
    //     }

    //     return const Center(child: Text('Something went wrong!'));
    //   },
    // );
  }

  AnimatedGridLayout _buildBrandsListItems(List<BrandEntity> brands) {
    return AnimatedGridLayout(
      itemCount: brands.length,
      mainAxisExtent: 80,
      itemBuilder: (context, index) => OpenContainerWrapper(
        nextScreen: BrandProductsPage(
          brand: brands[index],
        ),
        radius: const Radius.circular(AppSizes.cardRadiusLg),
        child: TBrandCard(
          brand: brands[index],
        ),
      ),
      animatedEffect: ({required child, onAdd, isVisible, onRemove}) =>
          AnimatedOffsetGridItem(
        isVisible: isVisible!,
        onRemove: onRemove!,
        child: child,
      ),
    );
  }

  Widget _loadingBrandsList() {
    return Skeletonizer(
      child: _buildBrandsListItems(
        List.generate(
          12,
          (index) => BrandEntity.empty(),
        ),
      ),
    );
  }
}
