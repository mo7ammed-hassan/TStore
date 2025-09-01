import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_widget.dart';

class ShimmerVerifyBrand extends StatelessWidget {
  const ShimmerVerifyBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShimmerWidget(
          height: 10,
          width: 50,
          margin: const EdgeInsets.only(bottom: 6),
          shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 7),
        const ShimmerWidget(
          height: 10,
          width: 10,
          margin: EdgeInsets.only(bottom: 6),
          shapeBorder: CircleBorder(),
        ),
      ],
    );
  }
}
