import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/home/presentation/cubits/banner/banner_cubit.dart';
import 'package:t_store/features/shop/features/home/presentation/cubits/home/promo_slider/promo_slider_cubit.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/slider/promo_carousel.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/slider/promo_slider_indicators.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/slider/shimmers/banner_placeholder.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_padding.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_text.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsivePadding.symmetric(
      vertical: TSizes.spaceBtwItems,
      horizontal: TSizes.spaceBtwItems,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PromoSliderCubit()),
          BlocProvider(create: (_) => BannerCubit()..fetchBanners()),
        ],
        child: BlocBuilder<BannerCubit, BannerState>(
          builder: (context, state) {
            if (state is BannerLoadingState || state is BannerInitial) {
              return const BannerPlaceholder();
            }

            if (state is BannerFailureState) {
              return Center(child: ResponsiveText(state.errorMessage));
            }

            if (state is BannerLoadedState) {
              final banners = state.allBanners;

              if (banners.isEmpty) {
                return const Center(child: ResponsiveText('No banners found!'));
              }

              return Column(
                children: [
                  TPromoCarousel(banners: banners),
                  ResponsiveGap.vertical(TSizes.spaceBtwItems),
                  TPromoSliderIndicators(length: banners.length),
                ],
              );
            }

            return const Center(
              child: ResponsiveText('Unexpected error occurred.'),
            );
          },
        ),
      ),
    );
  }
}
