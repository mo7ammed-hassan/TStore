// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_attribute_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAttributeModelAdapter extends TypeAdapter<ProductAttributeModel> {
  @override
  final int typeId = 5;

  @override
  ProductAttributeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductAttributeModel(
      name: fields[0] as String,
      values: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductAttributeModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.values);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAttributeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
