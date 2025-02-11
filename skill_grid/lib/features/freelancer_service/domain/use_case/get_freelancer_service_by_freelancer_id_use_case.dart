import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';
import 'package:skill_grid/features/freelancer_service/domain/repository/freelancer_service_repository.dart';

class GetFreelancerServiceByFreelancerIdParams {
  final String freelancerId;
  GetFreelancerServiceByFreelancerIdParams({required this.freelancerId});
}

class GetFreelancerServiceByFreelancerIdUseCase implements UsecaseWithParams<List<FreelancerServiceEntity>, GetFreelancerServiceByFreelancerIdParams> {
  final IFreelancerServiceRepository freelancerServiceRepository;
  GetFreelancerServiceByFreelancerIdUseCase({required this.freelancerServiceRepository});

  @override
  Future<Either<Failure, List<FreelancerServiceEntity>>> call(GetFreelancerServiceByFreelancerIdParams params) {
    return freelancerServiceRepository.getFreelancerServiceByFreelancerId(params.freelancerId);
  }
}