// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 4;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      id: fields[0] as String,
      stock: fields[1] as int,
      price: fields[2] as num,
      title: fields[3] as String,
      sku: fields[4] as String,
      date: fields[5] as DateTime?,
      salePrice: fields[6] as double,
      thumbnail: fields[7] as String,
      isFeatured: fields[8] as bool?,
      brand: fields[9] as BrandModel?,
      description: fields[10] as String?,
      categoryId: fields[11] as String?,
      images: (fields[12] as List).cast<String>(),
      productType: fields[13] as String,
      productAttributes: (fields[14] as List).cast<ProductAttributeModel>(),
      productVariations: (fields[15] as List).cast<ProductVariationModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.stock)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.sku)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.salePrice)
      ..writeByte(7)
      ..write(obj.thumbnail)
      ..writeByte(8)
      ..write(obj.isFeatured)
      ..writeByte(9)
      ..write(obj.brand)
      ..writeByte(10)
      ..write(obj.description)
      ..writeByte(11)
      ..write(obj.categoryId)
      ..writeByte(12)
      ..write(obj.images)
      ..writeByte(13)
      ..write(obj.productType)
      ..writeByte(14)
      ..write(obj.productAttributes)
      ..writeByte(15)
      ..write(obj.productVariations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
