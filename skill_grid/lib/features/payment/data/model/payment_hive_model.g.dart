// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentHiveModelAdapter extends TypeAdapter<PaymentHiveModel> {
  @override
  final int typeId = 11;

  @override
  PaymentHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentHiveModel(
      paymentId: fields[0] as String?,
      amount: fields[1] as int,
      paymentMethod: fields[2] as String,
      paymentStatus: fields[3] as bool,
      paymentTimestamp: fields[4] as DateTime?,
      appointment: fields[5] as AppointmentHiveModel,
      billingAddress: fields[6] as BillingAddressHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.paymentId)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.paymentMethod)
      ..writeByte(3)
      ..write(obj.paymentStatus)
      ..writeByte(4)
      ..write(obj.paymentTimestamp)
      ..writeByte(5)
      ..write(obj.appointment)
      ..writeByte(6)
      ..write(obj.billingAddress);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
