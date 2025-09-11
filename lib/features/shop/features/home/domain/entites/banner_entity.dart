// ignore_for_file: public_member_api_docs, sort_constructors_first
class BannerEntity {
  String imageUrl;
  final String targetScreen;
  final bool active;

  BannerEntity({
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
  });
}
