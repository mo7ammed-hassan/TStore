import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:t_store/features/shop/features/home/data/models/banner_model.dart';
import 'package:t_store/features/shop/features/home/presentation/cubits/banner/banner_cubit.dart';
import 'package:t_store/features/shop/features/home/presentation/cubits/home/promo_slider/promo_slider_cubit.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/slider/promo_carousel.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/slider/promo_slider_indicators.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PromoSliderCubit(),
        ),
        BlocProvider(
          create: (context) => BannerCubit()..fetchBanners(),
        ),
      ],
      child: BlocBuilder<BannerCubit, BannerState>(
        builder: (context, state) {
          if (state is BannerFailureState) {
            return Center(
              child: Text(state.errorMessage),
            );
          }

          if (state is BannerLoadingState || state is BannerInitial) {
            return _buildLoadingBanners();
          }

          if (state is BannerLoadedState) {
            if (state.allBanners.isEmpty) {
              return const Center(
                child: Text('No banners found!'),
              );
            }

            return Column(
              children: [
                TPromoCarousel(banners: state.allBanners),
                const SizedBox(height: AppSizes.spaceBtwItems),
                TPromoSliderIndicators(length: state.allBanners.length),
              ],
            );
          }

          return const Center(child: Text('Something went wrong!'));
        },
      ),
    );
  }

  Widget _buildLoadingBanners() {
    return Skeletonizer(
      child: Column(
        children: [
          TPromoCarousel(
            isLoading: true,
            banners: [
              BannerModel.empty().toEntity(),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          const TPromoSliderIndicators(length: 1),
        ],
      ),
    );
  }
}
