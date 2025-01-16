import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/repository/freelancer_repository.dart';

class DeleteFreelancerParams {
  final String freelancerId;
  DeleteFreelancerParams({required this.freelancerId});
}

class DeleteFreelancerUseCase implements UsecaseWithParams<void, DeleteFreelancerParams> {
  final IFreelancerRepository freelancerRepository;
  DeleteFreelancerUseCase({required this.freelancerRepository});

  @override
  Future<Either<Failure, void>> call(DeleteFreelancerParams params) {
    return freelancerRepository.deleteFreelancer(params.freelancerId);
  }
}