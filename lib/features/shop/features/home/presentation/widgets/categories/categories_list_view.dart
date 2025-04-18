import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/image_text_widgets/vertical_iamge_text.dart';
import 'package:t_store/features/shop/features/home/domain/entites/category_entity.dart';
import 'package:t_store/features/shop/features/sub_category/presentation/pages/sub_category_page.dart';
import 'package:t_store/utils/helpers/navigation.dart';

class CategoriesListView extends StatelessWidget {
  final List<CategoryEntity> categories;
  const CategoriesListView({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification.metrics.pixels ==
              scrollNotification.metrics.maxScrollExtent) {
            //context.read<CategoryCubit>().getAllCategories();
          }
          return true;
        },
        child: ListView.builder(
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return TVerticalImageText(
              image: categories[index].image,
              title: categories[index].name,
              onTap: () {
                context.pushPage(
                  SubCategoryPage(
                    category: categories[index],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
