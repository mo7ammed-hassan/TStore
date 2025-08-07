import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:t_store/common/widgets/animation_containers/open_container_wrapper.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
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
        bottomNavigationBar: TBottomAddToCart(product: product),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TProductDetailImageSlider(product: product),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: TSizes.defaultSpace,
                  right: TSizes.spaceBtwItems,
                  left: TSizes.spaceBtwItems,
                ),
                child: Column(
                  children: [
                    // -Rating & Share
                    const TRatingAndShare(),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    // - Price, Title, Stock, Brand
                    TProductMetaData(product: product),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    // - Attributes
                    if (product.productType == ProductType.variable.toString())
                      TProductAttributes(product: product),
                    if (product.productType == ProductType.variable.toString())
                      const SizedBox(height: TSizes.spaceBtwSections),
                    // - Checkout Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Checkout'),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    // -- Description
                    const TSectionHeading(
                      title: 'Description',
                      showActionButton: false,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    ReadMoreText(
                      product.description ??
                          'This is a Product description. there are more things that can be added to this description',
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: ' Show more',
                      trimExpandedText: ' Less',
                      moreStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w800),
                      lessStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w800),
                    ),

                    // Reviews
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const OpenContainerWrapper(
                      nextScreen: ProductReviewPage(),
                      radius: Radius.circular(0),
                      closedElevation: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TSectionHeading(
                            title: 'Reviews (175)',
                            showActionButton: false,
                          ),
                          IconButton(
                            onPressed: null,
                            icon: Icon(Iconsax.arrow_right_3, size: 18),
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
