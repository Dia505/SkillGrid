import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:skill_grid/app/constants/hive_table_constant.dart';
import 'package:skill_grid/features/service/domain/entity/service_entity.dart';
import 'package:uuid/uuid.dart';

part 'service_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.serviceTableId)
class ServiceHiveModel extends Equatable {
  @HiveField(0)
  final String serviceId;
  @HiveField(1)
  final String serviceName;

  ServiceHiveModel({
    String? serviceId,
    required this.serviceName
  })  : serviceId = serviceId ?? const Uuid().v4();

  const ServiceHiveModel.initial()
    : serviceId = "",
      serviceName = "";

  factory ServiceHiveModel.fromEntity(ServiceEntity entity) {
    return ServiceHiveModel(
      serviceId: entity.serviceId,
      serviceName: entity.serviceName
    );
  }

  ServiceEntity toEntity() {
    return ServiceEntity(
      serviceId: serviceId,
      serviceName: serviceName
    );
  }

  @override
  List<Object?> get props => [serviceId, serviceName];
}