// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EducationHiveModelAdapter extends TypeAdapter<EducationHiveModel> {
  @override
  final int typeId = 8;

  @override
  EducationHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EducationHiveModel(
      educationId: fields[0] as String?,
      degreeTitle: fields[1] as String,
      institutionName: fields[2] as String,
      startDate: fields[3] as DateTime,
      endDate: fields[4] as DateTime,
      freelancer: fields[5] as FreelancerHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, EducationHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.educationId)
      ..writeByte(1)
      ..write(obj.degreeTitle)
      ..writeByte(2)
      ..write(obj.institutionName)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.endDate)
      ..writeByte(5)
      ..write(obj.freelancer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EducationHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
