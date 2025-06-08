import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/animation_containers/open_container_wrapper.dart';
import 'package:t_store/common/widgets/brands/brand_show_case.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_brand_show_case.dart';
import 'package:t_store/features/shop/features/all_brands/domain/entities/brand_entity.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/pages/brand_products_page.dart';
import 'package:t_store/features/shop/features/store/presentation/cubits/store_cubit.dart';
import 'package:t_store/features/shop/features/store/presentation/cubits/store_state.dart';
import 'package:t_store/utils/constants/sizes.dart';

class BuildBrandList extends StatelessWidget {
  final String categoryId;
  const BuildBrandList({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    context
        .read<StoreCubit>()
        .fetchBrandsSpecificCategory(categoryId: categoryId);
    return BlocBuilder<StoreCubit, StoreState>(
      buildWhen: (previous, current) {
        if (current is StoreBrandLoaded ||
            current is StoreBrandError ||
            current is StoreBrandLoading) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is StoreBrandLoading) {
          return const ShimmerBrandShowCase();
        }

        if (state is StoreBrandLoaded) {
          if (state.brands.isEmpty) {
            return const Center(child: Text('No brands found!'));
          }

          return _buildBrandsListItems(state.brands);
        }

        if (state is StoreBrandError) {
          return Center(
            child: Text(state.error),
          );
        }

        return const Center(child: Text('Something went wrong!'));
      },
    );
  }

  Widget _buildBrandsListItems(List<BrandEntity> brands) {
    return Column(
      children: brands
          .map(
            (brand) => OpenContainerWrapper(
              nextScreen: BrandProductsPage(
                brand: brand,
              ),
              radius: const Radius.circular(AppSizes.cardRadiusLg),
              child: TBrandShowcase(brand: brand),
            ),
          )
          .toList(),
    );
  }
}
