// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PropertyHiveModelAdapter extends TypeAdapter<PropertyHiveModel> {
  @override
  final int typeId = 1;

  @override
  PropertyHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PropertyHiveModel(
      propertyId: fields[0] as String?,
      title: fields[1] as String,
      type: fields[2] as String,
      desc: fields[3] as String,
      img: fields[4] as String?,
      price: fields[5] as String?,
      sqmeters: fields[6] as String,
      continent: fields[7] as String,
      beds: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PropertyHiveModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.propertyId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.desc)
      ..writeByte(4)
      ..write(obj.img)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.sqmeters)
      ..writeByte(7)
      ..write(obj.continent)
      ..writeByte(8)
      ..write(obj.beds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PropertyHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
