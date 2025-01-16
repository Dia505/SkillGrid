// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClientHiveModelAdapter extends TypeAdapter<ClientHiveModel> {
  @override
  final int typeId = 0;

  @override
  ClientHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClientHiveModel(
      clientId: fields[0] as String?,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      mobileNo: fields[3] as String,
      city: fields[4] as String,
      email: fields[5] as String,
      password: fields[6] as String,
      profilePicture: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ClientHiveModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.clientId)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.mobileNo)
      ..writeByte(4)
      ..write(obj.city)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.password)
      ..writeByte(7)
      ..write(obj.profilePicture);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
