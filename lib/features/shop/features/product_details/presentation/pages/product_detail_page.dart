import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:t_store/common/widgets/animation_containers/open_container_wrapper.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/all_products/data/mapper/product_mapper.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/cart/data/mapper/product_cart_item_mapper.dart';
import 'package:t_store/features/checkout/presentation/pages/order_review_screen.dart';
import 'package:t_store/features/shop/features/product_details/presentation/cubits/images_product_cubit.dart';
import 'package:t_store/features/shop/features/product_details/presentation/cubits/product_variation_cubit.dart';
import 'package:t_store/features/shop/features/product_reviews/presentation/pages/product_review_page.dart';
import 'package:t_store/features/shop/features/product_details/presentation/widgets/bottom_add_to_cart.dart';
import 'package:t_store/features/shop/features/product_details/presentation/widgets/product_attribute.dart';
import 'package:t_store/features/shop/features/product_details/presentation/widgets/product_meta_data.dart';
import 'package:t_store/features/shop/features/product_details/presentation/widgets/product_detail_image_slider.dart';
import 'package:t_store/features/shop/features/product_details/presentation/widgets/rating_and_share.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/utils/responsive/widgets/responsive_padding.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ImagesProductCubit(),
        ),
        BlocProvider(
          create: (context) =>
              ProductVariationCubit()..initializeWithDefault(product),
        ),
      ],
      child: Scaffold(
        bottomNavigationBar:
            SafeArea(child: TBottomAddToCart(product: product)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TProductDetailImageSlider(product: product),
              ResponsivePadding.only(
                bottom: TSizes.defaultSpace,
                right: TSizes.spaceBtwItems,
                left: TSizes.spaceBtwItems,
                child: Column(
                  children: [
                    // -Rating & Share
                    const TRatingAndShare(),
                    ResponsiveGap.vertical(TSizes.spaceBtwItems / 2),
                    // - Price, Title, Stock, Brand
                    TProductMetaData(product: product),
                    ResponsiveGap.vertical(TSizes.spaceBtwItems + 5),
                    // - Attributes
                    if (product.productType == ProductType.variable.toString())
                      TProductAttributes(product: product),
                    if (product.productType == ProductType.variable.toString())
                      ResponsiveGap.vertical(TSizes.spaceBtwSections),
                    // - Checkout Button
                    SizedBox(
                      width: double.infinity,
                      child: Builder(builder: (context) {
                        return ElevatedButton(
                          onPressed: () {
                            final selectedariation = context
                                .read<ProductVariationCubit>()
                                .selectedVariation;

                            final cartItem = product
                                .toCartItemProductEntity(
                                  variation: selectedariation,
                                )
                                .toCartItemEntity();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OrderReviewScreen(items: [cartItem]),
                              ),
                            );
                          },
                          child: const ResponsiveText('Checkout'),
                        );
                      }),
                    ),
                    ResponsiveGap.vertical(TSizes.spaceBtwSections),
                    // -- Description
                    const TSectionHeading(
                      title: 'Description',
                      showActionButton: false,
                    ),
                    ResponsiveGap.vertical(TSizes.spaceBtwItems),
                    ReadMoreText(
                      product.description ??
                          'This is a Product description. there are more things that can be added to this description',
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: ' Show more',
                      trimExpandedText: ' Less',
                      moreStyle: TextStyle(
                        fontSize: getResponsiveFontSize(context, fontSize: 12),
                        fontWeight: FontWeight.w800,
                      ),
                      lessStyle: TextStyle(
                        fontSize: getResponsiveFontSize(context, fontSize: 12),
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    // Reviews
                    ResponsiveGap.vertical(TSizes.spaceBtwItems),
                    const Divider(),
                    ResponsiveGap.vertical(TSizes.spaceBtwItems / 2),
                    OpenContainerWrapper(
                      nextScreen: const ProductReviewPage(),
                      radius: const Radius.circular(0),
                      closedElevation: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TSectionHeading(
                            title: 'Reviews (175)',
                            showActionButton: false,
                          ),
                          IconButton(
                            onPressed: null,
                            icon: Icon(
                              Iconsax.arrow_right_3,
                              size: context.horzSize(18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
