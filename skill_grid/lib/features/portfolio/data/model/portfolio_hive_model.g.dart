// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PortfolioHiveModelAdapter extends TypeAdapter<PortfolioHiveModel> {
  @override
  final int typeId = 4;

  @override
  PortfolioHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PortfolioHiveModel(
      portfolioId: fields[0] as String?,
      filePath: (fields[1] as List).cast<String>(),
      uploadDate: fields[2] as DateTime,
      freelancerService: fields[3] as FreelancerServiceHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, PortfolioHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.portfolioId)
      ..writeByte(1)
      ..write(obj.filePath)
      ..writeByte(2)
      ..write(obj.uploadDate)
      ..writeByte(3)
      ..write(obj.freelancerService);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PortfolioHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
