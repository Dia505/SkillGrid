// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_address_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillingAddressHiveModelAdapter
    extends TypeAdapter<BillingAddressHiveModel> {
  @override
  final int typeId = 10;

  @override
  BillingAddressHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BillingAddressHiveModel(
      billingAddressId: fields[0] as String?,
      address: fields[1] as String,
      city: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BillingAddressHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.billingAddressId)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.city);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillingAddressHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
