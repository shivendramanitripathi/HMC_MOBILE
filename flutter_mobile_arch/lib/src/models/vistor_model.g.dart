// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vistor_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VisitorAdapter extends TypeAdapter<Visitor> {
  @override
  final int typeId = 0;

  @override
  Visitor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Visitor(
      name: fields[0] as String,
      phoneNumber: fields[1] as String,
      purpose: fields[2] as String,
      visitingDate: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Visitor obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.purpose)
      ..writeByte(3)
      ..write(obj.visitingDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisitorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
