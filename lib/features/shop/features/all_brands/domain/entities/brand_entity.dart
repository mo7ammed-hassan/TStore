import 'package:t_store/core/utils/constants/images_strings.dart';

class BrandEntity {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productCount;

  BrandEntity({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured,
    this.productCount,
  });

  int? get getProductCount => productCount;

  // -- empty --
  static BrandEntity empty() {
    return BrandEntity(
      id: '000',
      name: 'Name',
      image: TImages.defaultProductImage,
      productCount: 0,
      isFeatured: false,
    );
  }
}
