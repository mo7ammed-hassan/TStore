import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/animated_circular_container.dart';
import 'package:t_store/features/shop/features/home/presentation/cubits/home/promo_slider/promo_slider_cubit.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_edge_insets.dart';

class TPromoSliderIndicators extends StatelessWidget {
  final int length;
  const TPromoSliderIndicators({
    super.key,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromoSliderCubit, int>(
      builder: (context, state) {
        return Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              length,
              (index) => TAnimatedCircularConatiner(
                width: state == index ? 35 : 22,
                height: 3.2,
                margin: context.responsiveInsets.only(right: 8),
                backgroundColor:
                    state == index ? AppColors.primary : AppColors.grey,
              ),
            ),
          ),
        );
      },
    );
  }
}
