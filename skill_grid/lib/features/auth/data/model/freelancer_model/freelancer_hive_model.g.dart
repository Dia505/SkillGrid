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
      jobCategory: fields[9] as String?,
      profession: fields[10] as String?,
      skills: fields[11] as String?,
      yearsOfExperience: fields[12] as int?,
      bio: fields[13] as String?,
      available: fields[14] as bool?,
      profilePicture: fields[15] as String?,
      backgroundPicture: fields[16] as String?,
      role: fields[17] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FreelancerHiveModel obj) {
    writer
      ..writeByte(18)
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
      ..write(obj.jobCategory)
      ..writeByte(10)
      ..write(obj.profession)
      ..writeByte(11)
      ..write(obj.skills)
      ..writeByte(12)
      ..write(obj.yearsOfExperience)
      ..writeByte(13)
      ..write(obj.bio)
      ..writeByte(14)
      ..write(obj.available)
      ..writeByte(15)
      ..write(obj.profilePicture)
      ..writeByte(16)
      ..write(obj.backgroundPicture)
      ..writeByte(17)
      ..write(obj.role);
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
