import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store/utils/constants/sizes.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key, this.itemCount = 8});
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: ListView.separated(
        itemCount: itemCount,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ShimmerWidget(
                height: 56,
                width: 56,
                padding: EdgeInsets.all(AppSizes.sm),
                shapeBorder: CircleBorder(),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              ShimmerWidget(
                height: 8,
                width: 55,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: AppSizes.spaceBtwItems,
        ),
      ),
    );
  }
}
