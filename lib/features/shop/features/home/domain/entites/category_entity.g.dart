// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryEntityAdapter extends TypeAdapter<CategoryEntity> {
  @override
  final int typeId = 0;

  @override
  CategoryEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryEntity(
      id: fields[0] as String,
      name: fields[1] as String,
      image: fields[2] as String,
      parentId: fields[3] as String,
      isFeatured: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.parentId)
      ..writeByte(4)
      ..write(obj.isFeatured);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
