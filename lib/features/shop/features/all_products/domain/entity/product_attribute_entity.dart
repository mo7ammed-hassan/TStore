class ProductAttributeEntity {
  final String name; // Defaults to an empty string
  final List<String> values; // Defaults to an empty list

  const ProductAttributeEntity({
    this.name = '',
    this.values = const [],
  });
}
