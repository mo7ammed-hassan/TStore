import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/images/rounded_image.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';
import 'package:t_store/features/shop/features/product_details/presentation/cubits/images_product_cubit.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:t_store/utils/responsive/widgets/responsive_edge_insets.dart';

class BuildImagesSlider extends StatelessWidget {
  const BuildImagesSlider({super.key, required this.product});
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ImagesProductCubit>();
    final images = cubit.getAllProductImages(product);
    final isDark = HelperFunctions.isDarkMode(context);
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final image = images[index];
          return BlocBuilder<ImagesProductCubit, String>(
            builder: (context, selectedImage) {
              return GestureDetector(
                onTap: () => cubit.selectImage(image),
                child: TRoundedImage(
                  width: 80,
                  height: 80,
                  padding: context.responsiveInsets.all(TSizes.xs),
                  imageUrl: image,
                  backgroundColor: isDark ? AppColors.dark : AppColors.white,
                  border: Border.all(
                    color: selectedImage == image
                        ? AppColors.primary
                        : AppColors.grey,
                    width: 2,
                  ),
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) =>
            const SizedBox(width: TSizes.spaceBtwItems),
      ),
    );
  }
}
