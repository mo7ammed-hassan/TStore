class ProductAttributeUploadModel {
  String name;
  List<String> values;

  ProductAttributeUploadModel({
    required this.name,
    required this.values,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'values': values,
    };
  }

  factory ProductAttributeUploadModel.fromJson(Map<String, dynamic> data) {
    return ProductAttributeUploadModel(
      name: data['name'] ?? '',
      values: List<String>.from(data['values'] ?? []),
    );
  }
}
