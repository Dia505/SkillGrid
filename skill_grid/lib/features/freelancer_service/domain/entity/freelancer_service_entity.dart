import 'package:equatable/equatable.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/service/domain/entity/service_entity.dart';

class FreelancerServiceEntity extends Equatable {
  final String? freelancerServiceId;
  final int hourlyRate;
  final ServiceEntity service;
  final FreelancerEntity freelancer;

  const FreelancerServiceEntity(
      {this.freelancerServiceId,
      required this.hourlyRate,
      required this.service,
      required this.freelancer});

  FreelancerServiceEntity.empty()
      : freelancerServiceId = "_empty.freelancerServiceId",
        hourlyRate = 0,
        service = const ServiceEntity.empty(),
        freelancer = FreelancerEntity.empty();

  @override
  List<Object?> get props =>
      [freelancerServiceId, hourlyRate, service, freelancer];
}
