import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';

abstract interface class IFreelancerRepository {
  Future<Either<Failure, void>> registerFreelancer(FreelancerEntity freelancerEntity);
  Future<Either<Failure, void>> deleteFreelancer(String freelancerId);
  Future<Either<Failure, FreelancerEntity>> getFreelancerById(String freelancerId, String? token);
  Future<Either<Failure, List<FreelancerEntity>>> getAllFreelancer();
  Future<Either<Failure, String>> loginFreelancer(String email, String password);
  Future<Either<Failure, void>> updateFreelancer(FreelancerEntity freelancerEntity);
  Future<Either<Failure, List<FreelancerEntity>>> searchFreelancers(String searchQuery);
}