import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/repository/freelancer_repository.dart';

class GetFreelancerByIdParams {
  final String freelancerId;
  GetFreelancerByIdParams({required this.freelancerId});
}

class GetFreelancerByIdUseCase
    implements UsecaseWithParams<FreelancerEntity, GetFreelancerByIdParams> {
  final IFreelancerRepository freelancerRepository;
  GetFreelancerByIdUseCase({required this.freelancerRepository});

  @override
  Future<Either<Failure, FreelancerEntity>> call(
      GetFreelancerByIdParams params) {
    return freelancerRepository.getFreelancerById(params.freelancerId);
  }
}
