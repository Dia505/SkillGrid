import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  final String? serviceId;
  final String serviceName;

  const ServiceEntity({
    this.serviceId,
    required this.serviceName
  });

  @override
  List<Object?> get props => [serviceId, serviceName];
}