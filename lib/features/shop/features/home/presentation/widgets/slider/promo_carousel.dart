import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/images/rounded_image.dart';
import 'package:t_store/features/shop/features/home/domain/entites/banner_entity.dart';
import 'package:t_store/features/shop/features/home/presentation/cubits/home/promo_slider/promo_slider_cubit.dart';

class TPromoCarousel extends StatelessWidget {
  const TPromoCarousel(
      {super.key, required this.banners, this.isLoading = false});
  final List<BannerEntity> banners;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: banners
          .map(
            (banner) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: TRoundedImage(
                padding: const EdgeInsets.all(2),
                imageUrl: banner.imageUrl,
                isNetworkImage: true,
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        autoPlay: isLoading ? false : true,
        viewportFraction: 1,
        onPageChanged: (index, _) =>
            context.read<PromoSliderCubit>().updatePageIndicator(index),
      ),
    );
  }
}
