// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_cart_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductCartItemModelAdapter extends TypeAdapter<ProductCartItemModel> {
  @override
  final int typeId = 3;

  @override
  ProductCartItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductCartItemModel(
      id: fields[0] as String?,
      title: fields[1] as String?,
      price: fields[2] as double?,
      imageUrl: fields[3] as String?,
      variation: fields[4] as ProductVariationModel?,
      brand: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductCartItemModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.variation)
      ..writeByte(5)
      ..write(obj.brand);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductCartItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
