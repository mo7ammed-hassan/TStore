import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_brand_products_images.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/cubits/product_by_brand_cubit.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/cubits/product_by_brand_state.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';

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
            return const SizedBox.shrink();
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
      height: context.horzSize(85),
      width: context.horzSize(85),
      backgroundColor: HelperFunctions.isDarkMode(context)
          ? AppColors.darkerGrey
          : AppColors.light,
      margin: context.responsiveInsets.only(right: TSizes.sm),
      padding: context.responsiveInsets.all(TSizes.sm),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
        child: CachedNetworkImage(
          imageUrl: image,
          height: context.horzSize(85),
          width: context.horzSize(85),
          fit: BoxFit.contain,
          placeholder: (context, url) => ShimmerWidget(
            height: context.horzSize(85),
            width: context.horzSize(85),
          ),
          errorWidget: (context, error, stackTrace) =>
              const Icon(Icons.error_rounded),
        ),
      ),
    );
  }
}
