import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/shimmer/category_shimmer.dart';
import 'package:t_store/features/shop/features/home/presentation/cubits/category/category_cubit.dart';
import 'package:t_store/features/shop/features/home/presentation/cubits/category/category_state.dart';
import 'package:t_store/features/shop/features/home/presentation/widgets/categories/categories_list_view.dart';
import 'package:t_store/utils/responsive/widgets/responsive_text.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoadingState) {
          return const CategoryShimmer();
        }
        if (state is CategoryLoadedState) {
          if (state.featuredCategories.isEmpty) {
            return _errorWiget(context);
          }
          return CategoriesListView(categories: state.featuredCategories);
        }

        if (state is CategoryFailureState) {
          return Center(child: ResponsiveText(state.errorMessage));
        }

        return _errorWiget(context);
      },
    );
  }

  Center _errorWiget(BuildContext context) {
    return Center(
      child: ResponsiveText(
        'No Categories Found!',
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
      ),
    );
  }
}
