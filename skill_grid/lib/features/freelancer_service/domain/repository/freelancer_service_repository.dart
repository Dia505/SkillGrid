import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';

abstract interface class IFreelancerServiceRepository {
  Future<Either<Failure, List<FreelancerServiceEntity>>> getFreelancerServiceByFreelancerId(String freelancerId);
}