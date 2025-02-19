import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  final String? serviceId;
  final String serviceName;

  const ServiceEntity({
    this.serviceId,
    required this.serviceName
  });

  const ServiceEntity.empty()
    : serviceId = "_empty.serviceId",
      serviceName = "_empty.serviceName";

  @override
  List<Object?> get props => [serviceId, serviceName];
}