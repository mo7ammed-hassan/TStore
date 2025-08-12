// import 'package:flutter/material.dart';
// import 'package:t_store/common/widgets/shimmer/shimmer_bramds_list.dart';
// import 'package:t_store/features/shop/features/all_brands/presentation/cubits/brand_cubit.dart';
// import 'package:t_store/features/shop/features/all_brands/presentation/cubits/brand_state.dart';
// import 'package:t_store/features/shop/features/store/presentation/widgets/brands_grid_view.dart';
// import 'package:t_store/service_locator.dart';

// class BuildBrandsList extends StatelessWidget {
//   const BuildBrandsList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final brandCubit = getIt.get<BrandCubit>();

//     return brandCubit.state is BrandLoaded
//         ? brandCubit.allBrands.isEmpty
//             ? const SliverToBoxAdapter(
//                 child: Center(child: Text('No brands found!')),
//               )
//             : BrandsGridView(brands: brandCubit.allBrands)
//         : brandCubit.state is BrandLoading
//             ? SliverToBoxAdapter(child: ShimmerBramdsList())
//             : brandCubit.state is BrandError
//                 ? const SliverToBoxAdapter(
//                     child: Center(child: Text('There was an error!')),
//                   )
//                 : const SliverToBoxAdapter(child: SizedBox.shrink());

//     // return BlocBuilder<BrandCubit, BrandState>(
//     //   builder: (context, state) {
//     //     if (state is BrandLoading) {
//     //       return _loadingBrandsList();
//     //     }

//     //     if (state is BrandError) {
//     //       return Center(child: Text(state.allBrandsMessage!));
//     //     }

//     //     if (state is BrandLoaded) {
//     //       if (state.allbrands.isEmpty) {
//     //         return const Center(child: Text('No brands found!'));
//     //       }

//     //       return _buildBrandsListItems(getIt.get<BrandCubit>().allBrands);
//     //     }

//     //     return const Center(child: Text('Something went wrong!'));
//     //   },
//     // );
//   }
// }
