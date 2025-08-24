import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_bramds_list.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/cubits/brand_cubit.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/cubits/brand_state.dart';
import 'package:t_store/common/widgets/brand/brands_grid_view.dart';
import 'package:t_store/config/service_locator.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class BuildBrandsSection extends StatelessWidget {
  const BuildBrandsSection({super.key, this.feturerand = false});
  final bool feturerand;

  @override
  Widget build(BuildContext context) {
    final brandCubit = getIt.get<BrandCubit>();
    return BlocProvider(
      create: (context) => brandCubit..fetchInitialData(),
      child: SliverPadding(
        padding: context.responsiveInsets.only(bottom: TSizes.sm),
        sliver: BlocBuilder<BrandCubit, BrandState>(
          builder: (context, state) {
            if (state is BrandLoading || state is BrandInitial) {
              return SliverToBoxAdapter(
                child: ShimmerBramdsList(
                  itemCount: !feturerand ? 6 : 4,
                  key: ValueKey('loading brands'),
                ),
              );
            }

            if (state is BrandError) {
              return SliverToBoxAdapter(
                child:
                    Center(child: ResponsiveText(state.featuredBrandsMessage!)),
              );
            }

            if (state is BrandLoaded) {
              final brands =
                  feturerand ? state.featuredBrands : state.allbrands;

              if (brands.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(child: ResponsiveText('No brands found!')),
                );
              }

              return BrandsGridView(brands: brands);
            }

            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        ),
      ),
    );
  }
}
