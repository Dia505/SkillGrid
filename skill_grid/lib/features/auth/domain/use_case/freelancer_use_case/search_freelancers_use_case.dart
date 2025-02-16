import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/repository/freelancer_repository.dart';

class SearchFreelancersParams {
  final String searchQuery;
  SearchFreelancersParams({required this.searchQuery});
}

class SearchFreelancersUseCase implements UsecaseWithParams<List<FreelancerEntity>, SearchFreelancersParams> {
  final IFreelancerRepository freelancerRepository;
  SearchFreelancersUseCase({required this.freelancerRepository});

  @override
  Future<Either<Failure, List<FreelancerEntity>>> call(SearchFreelancersParams params) {
    return freelancerRepository.searchFreelancers(params.searchQuery);
  }
}