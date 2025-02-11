import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:skill_grid/features/service/domain/entity/service_entity.dart';

part 'service_api_model.g.dart';

@JsonSerializable()
class ServiceApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String? serviceId;
  @JsonKey(name: "service_name")
  final String serviceName;

  const ServiceApiModel({
    this.serviceId,
    required this.serviceName
  });

  factory ServiceApiModel.fromJson(Map<String, dynamic> json) {
    return _$ServiceApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ServiceApiModelToJson(this);

  factory ServiceApiModel.fromEntity(ServiceEntity entity) {
    return ServiceApiModel(
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