import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/responsive_helpers.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';

class ShimmerAddressCard extends StatelessWidget {
  const ShimmerAddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerWidget(
          height: context.horzSize(10),
          width: MediaQuery.sizeOf(context).width * 0.3,
        ),
        ResponsiveGap.vertical(TSizes.spaceBtwItems / 2),
        Row(
          children: [
            ShimmerWidget(
              height: context.horzSize(15),
              width: context.horzSize(15),
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(2)),
            ),
            const SizedBox(width: 5),
            ShimmerWidget(
              height: context.horzSize(10),
              width: MediaQuery.sizeOf(context).width * 0.3,
            )
          ],
        ),
        ResponsiveGap.vertical(TSizes.spaceBtwItems / 2),
        Row(
          children: [
            ShimmerWidget(
              height: context.horzSize(15),
              width: context.horzSize(15),
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(2)),
            ),
            const SizedBox(width: 5),
            ShimmerWidget(
              height: context.horzSize(10),
              width: MediaQuery.sizeOf(context).width * 0.43,
            )
          ],
        )
      ],
    );
  }
}
