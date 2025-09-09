import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/curved_edges/curved_edges_widgets.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/circular_conatiner.dart';
import 'package:t_store/core/utils/constants/colors.dart';

class TPrimaryHeaderConatiner extends StatelessWidget {
  final Widget child;
  const TPrimaryHeaderConatiner({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: SizedBox(
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.primary,
          ),
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: TCircularContainer(
                  backgroundColor: AppColors.textWhite.withValues(alpha: 0.1),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: TCircularContainer(
                  backgroundColor: AppColors.textWhite.withValues(alpha: 0.1),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
