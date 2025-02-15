// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppointmentHiveModelAdapter extends TypeAdapter<AppointmentHiveModel> {
  @override
  final int typeId = 5;

  @override
  AppointmentHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppointmentHiveModel(
      appointmentId: fields[0] as String?,
      appointmentPurpose: fields[1] as String,
      appointmentDate: fields[2] as DateTime,
      projectDuration: fields[3] as ProjectDurationHiveModel,
      projectEndDate: fields[4] as DateTime?,
      appointmentTime: fields[5] as String?,
      status: fields[6] as bool,
      freelancerService: fields[7] as FreelancerServiceHiveModel,
      client: fields[8] as ClientHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, AppointmentHiveModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.appointmentId)
      ..writeByte(1)
      ..write(obj.appointmentPurpose)
      ..writeByte(2)
      ..write(obj.appointmentDate)
      ..writeByte(3)
      ..write(obj.projectDuration)
      ..writeByte(4)
      ..write(obj.projectEndDate)
      ..writeByte(5)
      ..write(obj.appointmentTime)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.freelancerService)
      ..writeByte(8)
      ..write(obj.client);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppointmentHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProjectDurationHiveModelAdapter
    extends TypeAdapter<ProjectDurationHiveModel> {
  @override
  final int typeId = 6;

  @override
  ProjectDurationHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProjectDurationHiveModel(
      value: fields[0] as int,
      unit: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProjectDurationHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.value)
      ..writeByte(1)
      ..write(obj.unit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectDurationHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
