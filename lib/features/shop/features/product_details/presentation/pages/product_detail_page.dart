import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:t_store/common/widgets/animation_containers/open_container_wrapper.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/checkout/presentation/pages/checkout_page.dart';
import 'package:t_store/features/shop/features/product_details/presentation/cubits/images_product_cubit.dart';
import 'package:t_store/features/shop/features/product_reviews/presentation/pages/product_review_page.dart';
import 'package:t_store/features/shop/features/product_details/presentation/widgets/bottom_add_to_cart.dart';
import 'package:t_store/features/shop/features/product_details/presentation/widgets/product_attribute.dart';
import 'package:t_store/features/shop/features/product_details/presentation/widgets/product_meta_data.dart';
import 'package:t_store/features/shop/features/product_details/presentation/widgets/product_detail_image_slider.dart';
import 'package:t_store/features/shop/features/product_details/presentation/widgets/rating_and_share.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/navigation.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ImagesProductCubit(),
      child: Scaffold(
        bottomNavigationBar: TBottomAddToCart(product: product),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TProductDetailImageSlider(product: product),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: AppSizes.defaultSpace,
                  right: AppSizes.spaceBtwItems,
                  left: AppSizes.spaceBtwItems,
                ),
                child: Column(
                  children: [
                    // -Rating & Share
                    const TRatingAndShare(),
                    const SizedBox(height: AppSizes.spaceBtwItems / 2),
                    // - Price, Title, Stock, Brand
                    TProductMetaData(product: product),
                    const SizedBox(height: AppSizes.spaceBtwItems),
                    // - Attributes
                    if (product.productType == ProductType.variable.toString())
                      TProductAttributes(product: product),
                    if (product.productType == ProductType.variable.toString())
                      const SizedBox(height: AppSizes.spaceBtwSections),
                    // - Checkout Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.pushPage(const CheckoutPage());
                        },
                        child: const Text('Checkout'),
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections),
                    // -- Description
                    const TSectionHeading(
                      title: 'Description',
                      showActionButton: false,
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItems),
                    ReadMoreText(
                      product.description ??
                          'This is a Product description. there are more things that can be added to this description',
                      trimMode: TrimMode.Line,
                      trimCollapsedText: ' Show more',
                      trimExpandedText: ' Less',
                      moreStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w800),
                      lessStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w800),
                    ),

                    // Reviews
                    const SizedBox(height: AppSizes.spaceBtwItems),
                    const Divider(),
                    const SizedBox(height: AppSizes.spaceBtwItems),
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
