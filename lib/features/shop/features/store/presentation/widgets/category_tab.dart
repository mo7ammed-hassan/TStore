import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/models/get_all_products_param_model.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/features/all_products/domain/usecases/get_products_specific_category_use_case.dart';
import 'package:t_store/features/shop/features/all_products/presentation/pages/all_products_page.dart';
import 'package:t_store/features/shop/features/home/domain/entites/category_entity.dart';
import 'package:t_store/features/shop/features/store/presentation/cubits/store_cubit.dart';
import 'package:t_store/features/shop/features/store/presentation/widgets/build_brand_list.dart';
import 'package:t_store/features/shop/features/store/presentation/widgets/build_products_list.dart';
import 'package:t_store/service_locator.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/navigation.dart';

class TCategoryTab extends StatelessWidget {
  final CategoryEntity category;
  const TCategoryTab({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreCubit(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: TSizes.md, horizontal: TSizes.spaceBtwItems),
        child: CustomScrollView(
          slivers: [
            /// Brand List as Sliver
            BuildBrandList(categoryId: category.id),

            const SliverToBoxAdapter(
                child: SizedBox(height: TSizes.spaceBtwItems + 2)),

            /// Section Heading (title + button)
            SliverToBoxAdapter(
              child: TSectionHeading(
                title: 'You might like',
                showActionButton: true,
                onPressed: () {
                  context.pushPage(
                    AllProductsPage(
                      future: getIt
                          .get<GetProductsSpecificCategoryUseCase>()
                          .call(
                            params: GetAllParams(id: category.id, limit: 10),
                          ),
                      title: 'All Products',
                    ),
                  );
                },
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: TSizes.spaceBtwItems),
            ),

            ///  Product Grid as Sliver
            BuildProductsList(categoryId: category.id),

            /// Bottom spacing
            const SliverToBoxAdapter(
              child: SizedBox(height: TSizes.spaceBtwSections),
            ),
          ],
        ),
      ),
    );
  }
}
