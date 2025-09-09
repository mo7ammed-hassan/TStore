import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/curved_edges/curved_edges_widgets.dart';
import 'package:t_store/common/widgets/favorite_button/favorite_button.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/product_details/presentation/cubits/images_product_cubit.dart';
import 'package:t_store/features/shop/features/product_details/presentation/widgets/build_images_slider.dart';
import 'package:t_store/features/shop/features/product_details/presentation/widgets/show_enlarrged_image.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/images_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';

class TProductDetailImageSlider extends StatelessWidget {
  final ProductEntity product;
  const TProductDetailImageSlider({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return TCurvedEdgeWidget(
      child: Container(
        color: isDark ? AppColors.darkerGrey : AppColors.light,
        child: Stack(
          children: [
            _buildMainImage(context),
            Positioned(
              bottom: 30,
              right: 0,
              left: TSizes.defaultSpace,
              child: BuildImagesSlider(product: product),
            ),
            _appBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainImage(BuildContext context) {
    return BlocBuilder<ImagesProductCubit, String>(
      builder: (context, selectedImage) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.45,
          child: Center(
            child: Padding(
              padding: context.responsiveInsets.all(TSizes.productImageRadius * 2),
              child: GestureDetector(
                onTap: () => showEnlargedImage(selectedImage, context),
                child: CachedNetworkImage(
                  imageUrl: selectedImage.isEmpty
                      ? product.thumbnail.isNotEmpty
                          ? product.thumbnail
                          : TImages.defaultProductImage
                      : selectedImage,
                  fit: BoxFit.contain,
                  errorWidget: (context, error, stackTrace) =>
                      const Icon(Icons.error_rounded),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  TAppBar _appBar() {
    return TAppBar(
      showBackArrow: true,
      actions: [
        FavoriteButton(productId: product.id),
      ],
    );
  }
}
