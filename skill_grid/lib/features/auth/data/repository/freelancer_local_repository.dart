import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/data/data_source/local_data_source/freelancer_local_data_source.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/repository/freelancer_repository.dart';

class FreelancerLocalRepository implements IFreelancerRepository {
  FreelancerLocalDataSource _freelancerLocalDataSource;
  FreelancerLocalRepository({required FreelancerLocalDataSource freelancerLocalDataSource}) 
    :_freelancerLocalDataSource = freelancerLocalDataSource;

  @override
  Future<Either<Failure, void>> registerFreelancer(FreelancerEntity freelancerEntity) {
    try {
      _freelancerLocalDataSource.registerFreelancer(freelancerEntity);
      return Future.value(const Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFreelancer(String freelancerId) async {
    try {
      await _freelancerLocalDataSource.deleteFreelancer(freelancerId);
      return const Right(null);
    }
    catch (e) {
      return Left(LocalDatabaseFailure(message: "Error deleting client: $e"));
    }
  }

  @override
  Future<Either<Failure, FreelancerEntity>> getFreelancerById(String freelancerId) async {
    try {
      final freelancerEntity = await _freelancerLocalDataSource.getFreelancerById(freelancerId);
      return Right(freelancerEntity);
    }
    catch (e) {
      return Left(LocalDatabaseFailure(message: "Error getting client information: $e"));
    }
  }

  @override
  Future<Either<Failure, List<FreelancerEntity>>> getAllFreelancer() async {
    try {
      final freelancerList = await _freelancerLocalDataSource.getAllFreelancers();
      return Right(freelancerList);
    }
    catch (e) {
      return Left(LocalDatabaseFailure(message: "Error getting all freelancers: $e"));
    }
  }
}