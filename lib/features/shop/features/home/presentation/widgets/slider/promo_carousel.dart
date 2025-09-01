import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/images/rounded_image.dart';
import 'package:t_store/features/shop/features/home/domain/entites/banner_entity.dart';
import 'package:t_store/features/shop/features/home/presentation/cubits/home/promo_slider/promo_slider_cubit.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';

class TPromoCarousel extends StatelessWidget {
  const TPromoCarousel(
      {super.key, required this.banners, this.isLoading = false});
  final List<BannerEntity> banners;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: banners.length,
      itemBuilder: (context, index, realIndex) {
        final banner = banners[index];
        return TRoundedImage(
          imageUrl: banner.imageUrl,
          margin: context.responsiveInsets.symmetric(horizontal: 4),
          //isNetworkImage: true,
        );
      },
      options: CarouselOptions(
        autoPlay: isLoading ? false : true,
        autoPlayCurve: Curves.easeInOut,
        clipBehavior: Clip.none,
        viewportFraction: 1,
        onPageChanged: (index, _) =>
            context.read<PromoSliderCubit>().updatePageIndicator(index),
      ),
    );
  }
}
