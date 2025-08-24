import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_verify_brand.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/responsive/responsive_helpers.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';

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
            height: context.horzSize(110),
            width: context.horzSize(110),
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          ResponsiveGap.horizontal(8),
          Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget(
                    height: context.vertSize(10),
                    width: context.horzSize(100),
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  ResponsiveGap.vertical(8),
                  const ShimmerVerifyBrand(),
                  ResponsiveGap.vertical(8),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: ShimmerWidget(
                          height: context.vertSize(10),
                          width: context.horzSize(80),
                          shapeBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      ResponsiveGap.horizontal(8),
                      ShimmerWidget(
                        height: context.horzSize(35),
                        width: context.horzSize(35),
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
