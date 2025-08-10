import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_widget.dart';

class ShimmerCartItem extends StatelessWidget {
  const ShimmerCartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Image
            ShimmerWidget(
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(TSizes.sm),
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),

            /// Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Brand name
                  Row(
                    children: [
                      ShimmerWidget(
                        height: 10,
                        width: 40,
                        margin: const EdgeInsets.only(bottom: 6),
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 7),
                      ShimmerWidget(
                        height: 10,
                        width: 10,
                        margin: const EdgeInsets.only(bottom: 6),
                        shapeBorder: CircleBorder(),
                      ),
                    ],
                  ),

                  /// Product title
                  ShimmerWidget(
                    height: 14,
                    width: MediaQuery.sizeOf(context).width * 0.35,
                    margin: const EdgeInsets.only(bottom: 6),
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  /// Variations (Color / Size)
                  Row(
                    children: [
                      ShimmerWidget(
                        height: 10,
                        width: 40,
                        margin: const EdgeInsets.only(right: 10),
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      ShimmerWidget(
                        height: 10,
                        width: 40,
                        margin: const EdgeInsets.only(right: 10),
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Quantity buttons and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Quantity buttons placeholder
                      Row(
                        children: List.generate(3, (index) {
                          return ShimmerWidget(
                            width: 28,
                            height: 28,
                            margin: EdgeInsets.only(right: index < 2 ? 6 : 0),
                            shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          );
                        }),
                      ),

                      /// Price
                      ShimmerWidget(
                        height: 16,
                        width: 40,
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
