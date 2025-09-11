class ProductVariationUploadModel {
  String id;
  String? sku;
  String image;
  String? description;
  double price;
  double? salePrice;
  int stock;
  Map<String, String> attributeValues;

  ProductVariationUploadModel({
    required this.id,
    this.sku,
    required this.image,
    this.description,
    required this.price,
    this.salePrice,
    required this.stock,
    this.attributeValues = const {},
  });

  // Future<void> uploadData(String collection) async {
  //   try {
  //     final imageFile = await getIt<FirebaseStorageServices>().getImageDataFromAssets(image);
  //     final imageUrl = await getIt<FirebaseStorageServices>().uploadImageData(collection, imageFile, image);
  //     image = imageUrl;
  //   } catch (e) {
  //     print("Error uploading variation image: $e");
  //   }
  // }

  Map<String, dynamic> toJson() {
    return {
      'sku': sku,
      'image': image,
      'description': description,
      'price': price,
      'salePrice': salePrice,
      'stock': stock,
      'attributeValues': attributeValues,
    };
  }

  factory ProductVariationUploadModel.fromJson(Map<String, dynamic> data) {
    return ProductVariationUploadModel(
      id: data['id'],
      sku: data['sku'],
      image: data['image'],
      description: data['description'],
      price: data['price'],
      salePrice: data['salePrice'],
      stock: data['stock'],
      attributeValues: Map<String, String>.from(data['attributeValues'] ?? {}),
    );
  }
}
