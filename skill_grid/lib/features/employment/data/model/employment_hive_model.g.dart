// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employment_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmploymentHiveModelAdapter extends TypeAdapter<EmploymentHiveModel> {
  @override
  final int typeId = 9;

  @override
  EmploymentHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmploymentHiveModel(
      employmentId: fields[0] as String?,
      companyName: fields[1] as String,
      jobTitle: fields[2] as String,
      startDate: fields[3] as DateTime,
      endDate: fields[4] as DateTime?,
      description: fields[5] as String?,
      freelancer: fields[6] as FreelancerHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, EmploymentHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.employmentId)
      ..writeByte(1)
      ..write(obj.companyName)
      ..writeByte(2)
      ..write(obj.jobTitle)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.endDate)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.freelancer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmploymentHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
