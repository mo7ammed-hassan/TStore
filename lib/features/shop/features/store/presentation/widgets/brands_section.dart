import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_brand_show_case.dart';
import 'package:t_store/features/shop/features/store/presentation/cubits/store_cubit.dart';
import 'package:t_store/features/shop/features/store/presentation/cubits/store_state.dart';
import 'package:t_store/features/shop/features/store/presentation/widgets/brand_list_view.dart';

class BrandsSection extends StatelessWidget {
  const BrandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreCubit, StoreState>(
      buildWhen: (previous, current) =>
          current is StoreBrandLoaded ||
          current is StoreBrandError ||
          current is StoreBrandLoading,
      builder: (context, state) {
        if (state is StoreBrandLoading) {
          return const SliverToBoxAdapter(child: ShimmerBrandShowCase());
        }

        if (state is StoreBrandLoaded) {
          if (state.brands.isEmpty) {
            return const SliverToBoxAdapter(
              child: Center(child: Text('No brands found!')),
            );
          }

          return BrandListView(brands: state.brands);
        }

        if (state is StoreBrandError) {
          return SliverToBoxAdapter(
            child: Center(child: Text(state.error)),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
