// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freelancer_service_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FreelancerServiceHiveModelAdapter
    extends TypeAdapter<FreelancerServiceHiveModel> {
  @override
  final int typeId = 3;

  @override
  FreelancerServiceHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FreelancerServiceHiveModel(
      freelancerServiceId: fields[0] as String?,
      hourlyRate: fields[1] as int,
      service: fields[2] as ServiceHiveModel,
      freelancer: fields[3] as FreelancerHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, FreelancerServiceHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.freelancerServiceId)
      ..writeByte(1)
      ..write(obj.hourlyRate)
      ..writeByte(2)
      ..write(obj.service)
      ..writeByte(3)
      ..write(obj.freelancer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FreelancerServiceHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
