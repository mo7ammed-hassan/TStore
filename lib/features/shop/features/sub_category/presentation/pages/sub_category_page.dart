import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/images/rounded_image.dart';
import 'package:t_store/features/shop/features/home/domain/entites/category_entity.dart';
import 'package:t_store/features/shop/features/sub_category/presentation/cubits/sub_category_cubit.dart';
import 'package:t_store/features/shop/features/sub_category/presentation/widgets/build_sub_categories.dart';
import 'package:t_store/core/utils/constants/images_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_gap.dart';
import 'package:t_store/core/utils/responsive/widgets/responsive_padding.dart';

class SubCategoryPage extends StatelessWidget {
  final CategoryEntity category;
  const SubCategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return BlocProvider(
      create: (context) =>
          SubCategoryCubit()..fetchSubCategory(categoryId: category.id),
      child: Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: category.name,
        ),
        body: ResponsivePadding.symmetric(
          horizontal: TSizes.spaceBtwItems,
          vertical: TSizes.defaultSpace,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey : Colors.transparent,
                    borderRadius: BorderRadius.circular(TSizes.md),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: TRoundedImage(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.18,
                    imageUrl: TImages.defaultProductImage,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ResponsiveGap.vertical(TSizes.spaceBtwSections / 2),
              ),
              const BuildSubCategoriesSections(),
            ],
          ),
        ),
      ),
    );
  }
}
