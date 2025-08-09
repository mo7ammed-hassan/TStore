import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/sub_category/presentation/cubits/sub_category_cubit.dart';
import 'package:t_store/features/shop/features/sub_category/presentation/cubits/sub_category_state.dart';
import 'package:t_store/features/shop/features/sub_category/presentation/widgets/sub_category_section.dart';

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
          return Center(child: CircularProgressIndicator());
        }

        if (state is SubCategoryFailure) {
          return Center(child: Text(state.error));
        }

        if (state is SubCategoryLoaded) {
          if (state.subCategories.isEmpty) {
            return const Center(child: Text('No sub categories found'));
          }

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: ListView.builder(
              itemCount: state.subCategories.length,
              itemBuilder: (context, index) {
                final subCategory = state.subCategories[index];
                return SubCategorySection(subCategory: subCategory);
              },
            ),
          );
        }

        return const Center(child: Text('Something went wrong!'));
      },
    );
  }
}
