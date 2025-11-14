// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoleTypeAdapter extends TypeAdapter<RoleType> {
  @override
  final int typeId = 2;

  @override
  RoleType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RoleType.none;
      case 1:
        return RoleType.customer;
      case 2:
        return RoleType.vendor;
      default:
        return RoleType.none;
    }
  }

  @override
  void write(BinaryWriter writer, RoleType obj) {
    switch (obj) {
      case RoleType.none:
        writer.writeByte(0);
        break;
      case RoleType.customer:
        writer.writeByte(1);
        break;
      case RoleType.vendor:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoleTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
