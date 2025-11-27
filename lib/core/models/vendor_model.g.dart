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
      id: fields[0] as String,
      name: fields[1] as String,
      username: fields[2] as String,
      email: fields[3] as String,
      companyName: fields[4] as String,
      companyLogo: fields[5] as String?,
      personName: fields[6] as String,
      address: fields[7] as String,
      city: fields[8] as String,
      phoneNumber: fields[9] as String,
      primaryCategory: fields[10] as String,
      additionalCategories: (fields[11] as List).cast<String>(),
      features: (fields[12] as List).cast<String>(),
      links: (fields[13] as List).cast<String>(),
      status: fields[14] as String,
      businessDescription: fields[15] as String,
      isVerified: fields[16] as bool,
      reviews: fields[17] as int,
      ratings: fields[18] as double,
      pricePerPerson: fields[19] as double,
      capacity: fields[20] as int,
      createdAt: fields[21] as String,
      updatedAt: fields[22] as String,
      approvedAt: fields[23] as String?,
      rejectedAt: fields[24] as String?,
      rejectionReason: fields[25] as String?,
      media: (fields[26] as List).cast<VendorMedia>(),
    );
  }

  @override
  void write(BinaryWriter writer, VendorModel obj) {
    writer
      ..writeByte(27)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.companyName)
      ..writeByte(5)
      ..write(obj.companyLogo)
      ..writeByte(6)
      ..write(obj.personName)
      ..writeByte(7)
      ..write(obj.address)
      ..writeByte(8)
      ..write(obj.city)
      ..writeByte(9)
      ..write(obj.phoneNumber)
      ..writeByte(10)
      ..write(obj.primaryCategory)
      ..writeByte(11)
      ..write(obj.additionalCategories)
      ..writeByte(12)
      ..write(obj.features)
      ..writeByte(13)
      ..write(obj.links)
      ..writeByte(14)
      ..write(obj.status)
      ..writeByte(15)
      ..write(obj.businessDescription)
      ..writeByte(16)
      ..write(obj.isVerified)
      ..writeByte(17)
      ..write(obj.reviews)
      ..writeByte(18)
      ..write(obj.ratings)
      ..writeByte(19)
      ..write(obj.pricePerPerson)
      ..writeByte(20)
      ..write(obj.capacity)
      ..writeByte(21)
      ..write(obj.createdAt)
      ..writeByte(22)
      ..write(obj.updatedAt)
      ..writeByte(23)
      ..write(obj.approvedAt)
      ..writeByte(24)
      ..write(obj.rejectedAt)
      ..writeByte(25)
      ..write(obj.rejectionReason)
      ..writeByte(26)
      ..write(obj.media);
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

class VendorMediaAdapter extends TypeAdapter<VendorMedia> {
  @override
  final int typeId = 4;

  @override
  VendorMedia read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VendorMedia(
      type: fields[0] as String,
      fileUrl: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VendorMedia obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.fileUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VendorMediaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
