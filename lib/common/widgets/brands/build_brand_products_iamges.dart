import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_brand_products_images.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/cubits/product_by_brand_cubit.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/cubits/product_by_brand_state.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class BuildBrandProductsImages extends StatelessWidget {
  const BuildBrandProductsImages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsByBrandCubit, ProductsByBrandState>(
      builder: (context, state) {
        if (state is ProductsByBrandLoadingState ||
            state is ProductsByBrandInitialState) {
          return const ShimmerBrandProductsImages();
        }

        if (state is ProductsByBrandErrorState) {
          return Center(child: Text(state.message));
        }

        if (state is ProductsByBrandLoadedState) {
          if (state.products.isEmpty) {
            return const SizedBox();
          }

          return Row(
            children: state.products
                .map(
                  (product) => state.products.length > 2
                      ? Expanded(
                          child:
                              _topBrandImage(context, image: product.thumbnail),
                        )
                      : _topBrandImage(context, image: product.thumbnail),
                )
                .toList(),
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _topBrandImage(BuildContext context, {required String image}) {
    return TRoundedContainer(
      height: 100,
      backgroundColor: HelperFunctions.isDarkMode(context)
          ? AppColors.darkerGrey
          : AppColors.light,
      margin: const EdgeInsets.only(right: TSizes.sm),
      padding: const EdgeInsets.all(TSizes.md),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.contain,
          errorWidget: (context, error, stackTrace) =>
              const Icon(Icons.error_rounded),
        ),
      ),
    );
  }
}
