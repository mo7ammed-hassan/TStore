// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/features/shop/features/home/domain/entites/banner_entity.dart';
import 'package:t_store/utils/constants/images_strings.dart';

class BannerModel {
  String? id;
  String image;
  final String targetScreen;
  final bool active;

  BannerModel({
    required this.image,
    required this.targetScreen,
    required this.active,
    this.id,
  });

  static BannerModel empty() =>
      BannerModel(image: TImages.defaultProductImage, targetScreen: '', active: false);

  Map<String, dynamic> toJson() => {
        'Image': image,
        'TargetScreen': targetScreen,
        'Active': active,
        'id': id,
      };

  factory BannerModel.fromJson(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BannerModel(
      id: snapshot.id,
      image: data['Image'] ?? '',
      targetScreen: data['TargetScreen'] ?? '',
      active: data['Active'] ?? false,
    );
  }
}

extension BannerXModel on BannerModel {
  BannerEntity toEntity() {
    return BannerEntity(
      imageUrl: image,
      targetScreen: targetScreen,
      active: active,
    );
  }
}
