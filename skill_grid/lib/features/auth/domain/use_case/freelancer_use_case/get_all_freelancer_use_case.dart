import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/repository/freelancer_repository.dart';

class GetAllFreelancerUseCase implements UsecaseWithoutParams<List<FreelancerEntity>> {
  final IFreelancerRepository freelancerRepository;
  GetAllFreelancerUseCase({required this.freelancerRepository});

  @override
  Future<Either<Failure, List<FreelancerEntity>>> call() {
    return freelancerRepository.getAllFreelancer();
  }
}