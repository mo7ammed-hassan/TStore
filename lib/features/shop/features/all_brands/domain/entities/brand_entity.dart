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

  // -- empty --
  static BrandEntity empty() {
    return BrandEntity(
      id: '',
      name: 'Name',
      image: '',
      productCount: 0,
      isFeatured: false,
    );
  }
}
