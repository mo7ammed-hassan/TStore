import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:t_store/common/widgets/shimmer/shimmer_sub_category_products.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/sub_category/presentation/cubits/sub_category_cubit.dart';
import 'package:t_store/features/shop/features/sub_category/presentation/cubits/sub_category_state.dart';
import 'package:t_store/features/shop/features/sub_category/presentation/widgets/sub_category_section.dart';
import 'package:t_store/utils/constants/sizes.dart';

class BuildSubCategoriesSections extends StatelessWidget {
  const BuildSubCategoriesSections({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubCategoryCubit, SubCategoryState>(
      buildWhen: (previous, current) {
        if (current is SubCategoryLoaded ||
            current is SubCategoryLoading ||
            current is SubCategoryFailure) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is SubCategoryLoading) {
          return _buildLoadingSubCategorySection();
        }

        if (state is SubCategoryFailure) {
          return Center(child: Text(state.error));
        }

        if (state is SubCategoryLoaded) {
          if (state.subCategories.isEmpty) {
            return const Center(child: Text('No sub categories found'));
          }

          return Column(
            children: state.subCategories.map(
              (subCategory) {
                return SubCategorySection(subCategory: subCategory);
              },
            ).toList(),
          );
        }

        return const Center(child: Text('Something went wrong!'));
      },
    );
  }

  Widget _buildLoadingSubCategorySection() {
    return Skeletonizer(
      child: Column(
        children: [
          TSectionHeading(
            title: 'Sub Category',
            onPressed: () {},
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          const ShimmerSubCategoryProducts(),
        ],
      ),
    );
  }
}
