import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_verify_brand.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store/utils/constants/colors.dart';

class ShimmerHorizantalProductCard extends StatelessWidget {
  const ShimmerHorizantalProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDark ? AppColors.dark : AppColors.light,
      ),
      child: Row(
        children: [
          ShimmerWidget(
            height: 120,
            width: 120,
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget(
                    height: 10,
                    width: 100,
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const ShimmerVerifyBrand(),
                  const SizedBox(height: 8),
                  Spacer(),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: ShimmerWidget(
                          height: 10,
                          shapeBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ShimmerWidget(
                        height: 35,
                        width: 35,
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
