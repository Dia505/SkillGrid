// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReviewHiveModelAdapter extends TypeAdapter<ReviewHiveModel> {
  @override
  final int typeId = 7;

  @override
  ReviewHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReviewHiveModel(
      reviewId: fields[0] as String?,
      review: fields[1] as String,
      rating: fields[2] as int,
      reviewDate: fields[3] as DateTime,
      client: fields[4] as ClientHiveModel,
      freelancer: fields[5] as FreelancerHiveModel,
      appointment: fields[6] as AppointmentHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, ReviewHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.reviewId)
      ..writeByte(1)
      ..write(obj.review)
      ..writeByte(2)
      ..write(obj.rating)
      ..writeByte(3)
      ..write(obj.reviewDate)
      ..writeByte(4)
      ..write(obj.client)
      ..writeByte(5)
      ..write(obj.freelancer)
      ..writeByte(6)
      ..write(obj.appointment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
