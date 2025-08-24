import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_verify_brand.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/responsive/widgets/responsive_gap.dart';

class ShimmerVerticalProductCard extends StatelessWidget {
  const ShimmerVerticalProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDark ? AppColors.dark : AppColors.light,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: ShimmerWidget(
              height: 180,
              width: double.infinity,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          ResponsiveGap.vertical(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                ResponsiveGap.vertical(16),
                const ShimmerVerifyBrand(),
              ],
            ),
          ),
          Spacer(),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: ShimmerWidget(
                    height: 10,
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              ResponsiveGap.horizontal(8),
              ShimmerWidget(
                height: 35,
                width: 35,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
