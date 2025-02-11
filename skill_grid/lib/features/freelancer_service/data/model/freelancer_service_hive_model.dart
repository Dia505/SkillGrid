import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:skill_grid/app/constants/hive_table_constant.dart';
import 'package:skill_grid/features/auth/data/model/freelancer_model/freelancer_hive_model.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';
import 'package:skill_grid/features/service/data/model/service_hive_model.dart';
import 'package:uuid/uuid.dart';

part 'freelancer_service_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.freelancerServiceTableId)
class FreelancerServiceHiveModel extends Equatable {
  @HiveField(0)
  final String? freelancerServiceId;
  @HiveField(1)
  final int hourlyRate;
  @HiveField(2)
  final ServiceHiveModel service;
  @HiveField(3)
  final FreelancerHiveModel freelancer;

  FreelancerServiceHiveModel({
    String? freelancerServiceId,
    required this.hourlyRate,
    required this.service,
    required this.freelancer
  })  : freelancerServiceId = freelancerServiceId ?? const Uuid().v4();

  FreelancerServiceHiveModel.initial()
    : freelancerServiceId = "",
      hourlyRate = 0,
      service = const ServiceHiveModel.initial(),
      freelancer = FreelancerHiveModel.initial();

  factory FreelancerServiceHiveModel.fromEntity(FreelancerServiceEntity entity) {
    return FreelancerServiceHiveModel(
      freelancerServiceId: entity.freelancerServiceId,
      hourlyRate: entity.hourlyRate,
      service: ServiceHiveModel.fromEntity(entity.service),
      freelancer: FreelancerHiveModel.fromEntity(entity.freelancer)
    );
  }

  FreelancerServiceEntity toEntity() {
    return FreelancerServiceEntity(
      freelancerServiceId: freelancerServiceId,
      hourlyRate: hourlyRate, 
      service: service.toEntity(), 
      freelancer: freelancer.toEntity()
    );
  }

  @override
  List<Object?> get props => [freelancerServiceId, hourlyRate, service, freelancer];
}