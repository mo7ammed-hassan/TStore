import 'package:hive/hive.dart';

part 'product_attribute_model.g.dart';

@HiveType(typeId: 5) 
class ProductAttributeModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final List<String> values;

  const ProductAttributeModel({
    this.name = '',
    this.values = const [],
  });

  static ProductAttributeModel empty() => const ProductAttributeModel();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'values': values,
    };
  }

  factory ProductAttributeModel.fromJson(Map<String, dynamic> data) {
    return ProductAttributeModel(
      name: data['name'] ?? '',
      values: List<String>.from(data['values'] ?? []),
    );
  }
}
