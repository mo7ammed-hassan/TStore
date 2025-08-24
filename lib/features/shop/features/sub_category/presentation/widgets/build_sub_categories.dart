import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/sub_category/presentation/cubits/sub_category_cubit.dart';
import 'package:t_store/features/shop/features/sub_category/presentation/cubits/sub_category_state.dart';
import 'package:t_store/features/shop/features/sub_category/presentation/widgets/sub_category_section.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class BuildSubCategoriesSections extends StatelessWidget {
  const BuildSubCategoriesSections({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubCategoryCubit, SubCategoryState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        if (state is SubCategoryLoading) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is SubCategoryFailure) {
          return SliverToBoxAdapter(child: Center(child: Text(state.error)));
        }

        if (state is SubCategoryLoaded) {
          if (state.subCategories.isEmpty) {
            return const SliverToBoxAdapter(
              child: Center(child: ResponsiveText('No sub categories found')),
            );
          }

          return SliverList.builder(
            itemCount: state.subCategories.length,
            itemBuilder: (context, index) {
              final subCategory = state.subCategories[index];
              return SubCategorySection(subCategory: subCategory);
            },
          );
        }

        return const SliverToBoxAdapter();
      },
    );
  }

  bool _buildWhen(SubCategoryState previous, SubCategoryState current) {
    if (current is SubCategoryLoaded ||
        current is SubCategoryLoading ||
        current is SubCategoryFailure) {
      return true;
    }
    return false;
  }
}
