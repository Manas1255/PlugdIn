// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VendorModelAdapter extends TypeAdapter<VendorModel> {
  @override
  final int typeId = 3;

  @override
  VendorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VendorModel(
      name: fields[0] as String,
      username: fields[1] as String,
      email: fields[2] as String,
      companyName: fields[3] as String,
      companyLogo: fields[4] as String,
      personName: fields[5] as String,
      address: fields[6] as String,
      city: fields[7] as String,
      phoneNumber: fields[8] as String,
      primaryCategory: fields[9] as String,
      additionalCategories: (fields[10] as List).cast<String>(),
      businessDescription: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VendorModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.companyName)
      ..writeByte(4)
      ..write(obj.companyLogo)
      ..writeByte(5)
      ..write(obj.personName)
      ..writeByte(6)
      ..write(obj.address)
      ..writeByte(7)
      ..write(obj.city)
      ..writeByte(8)
      ..write(obj.phoneNumber)
      ..writeByte(9)
      ..write(obj.primaryCategory)
      ..writeByte(10)
      ..write(obj.additionalCategories)
      ..writeByte(11)
      ..write(obj.businessDescription);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VendorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
