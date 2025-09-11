import 'package:hive/hive.dart';

part 'brand_model.g.dart';

@HiveType(typeId: 4)
class BrandModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String image;

  @HiveField(3)
  bool? isFeatured;

  @HiveField(4)
  int? productCount;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    required this.productCount,
  });

  // نفس الدوال زي الأول
  static BrandModel empty() => BrandModel(
        id: '',
        name: '',
        image: '',
        isFeatured: false,
        productCount: 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'isFeatured': isFeatured,
        'productCount': productCount,
      };

  factory BrandModel.fromJson(Map<String, dynamic> map) => BrandModel(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        image: map['image'] ?? '',
        isFeatured: map['isFeatured'] ?? false,
        productCount: map['productCount'] ?? 0,
      );
}
