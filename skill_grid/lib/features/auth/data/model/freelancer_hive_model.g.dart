// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freelancer_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FreelancerHiveModelAdapter extends TypeAdapter<FreelancerHiveModel> {
  @override
  final int typeId = 1;

  @override
  FreelancerHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FreelancerHiveModel(
      freelancerId: fields[0] as String?,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      dateOfBirth: fields[3] as DateTime,
      mobileNo: fields[4] as String,
      address: fields[5] as String,
      city: fields[6] as String,
      email: fields[7] as String,
      password: fields[8] as String,
      profilePicture: fields[9] as String?,
      backgroundPicture: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FreelancerHiveModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.freelancerId)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.dateOfBirth)
      ..writeByte(4)
      ..write(obj.mobileNo)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.city)
      ..writeByte(7)
      ..write(obj.email)
      ..writeByte(8)
      ..write(obj.password)
      ..writeByte(9)
      ..write(obj.profilePicture)
      ..writeByte(10)
      ..write(obj.backgroundPicture);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FreelancerHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
