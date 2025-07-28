import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/images/rounded_image.dart';
import 'package:t_store/features/shop/features/sub_category/presentation/cubits/sub_category_cubit.dart';
import 'package:t_store/features/shop/features/sub_category/presentation/widgets/build_sub_categories.dart';
import 'package:t_store/utils/constants/images_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class SubCategoryPage extends StatelessWidget {
  final String categoryId;
  const SubCategoryPage({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SubCategoryCubit()..fetchSubCategory(categoryId: categoryId),
      child: Scaffold(
        appBar: _appBar(context),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: TSizes.spaceBtwItems,
              vertical: TSizes.defaultSpace,
            ),
            child: Column(
              children: [
                TRoundedImage(
                  width: double.infinity,
                  aplayImageRaduis: true,
                  imageUrl: TImages.defaultProductImage,
                ),
                SizedBox(height: TSizes.spaceBtwSections),
                BuildSubCategoriesSections(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TAppBar _appBar(BuildContext context) {
    return TAppBar(
      showBackArrow: true,
      title: Text(
        'Sport',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
