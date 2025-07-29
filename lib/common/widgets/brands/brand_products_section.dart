import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/common/widgets/brands/build_brand_products_images.dart';
import 'package:t_store/features/shop/features/all_brands/presentation/cubits/product_by_brand_cubit.dart';

class BrandProductsSection extends StatelessWidget {
  final String brandId;
  const BrandProductsSection({super.key, required this.brandId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsByBrandCubit()
        ..fetchProductsByBrand(brandId: brandId, limit: 3),
      child: const BuildBrandProductsImages(),
    );
  }
}
