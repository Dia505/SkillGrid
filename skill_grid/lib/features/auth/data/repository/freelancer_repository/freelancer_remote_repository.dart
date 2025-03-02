import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/data/data_source/remote_data_source/freelancer_remote_data_source.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/repository/freelancer_repository.dart';

class FreelancerRemoteRepository implements IFreelancerRepository {
  final FreelancerRemoteDataSource _freelancerRemoteDataSource;
  
  FreelancerRemoteRepository({required FreelancerRemoteDataSource freelancerRemoteDataSource})
    : _freelancerRemoteDataSource = freelancerRemoteDataSource;

  @override
  Future<Either<Failure, void>> registerFreelancer(FreelancerEntity freelancerEntity) async {
    try {
      _freelancerRemoteDataSource.registerFreelancer(freelancerEntity);
      return const Right(null);
    }
    catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFreelancer(String freelancerId) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<FreelancerEntity>>> getAllFreelancer() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, FreelancerEntity>> getFreelancerById(String freelancerId, String? token) async {
    try {
      final freelancer = await _freelancerRemoteDataSource.getFreelancerById(freelancerId, token);
      return Right(freelancer);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginFreelancer(String email, String password) async {
    try {
      final token = await _freelancerRemoteDataSource.loginFreelancer(email, password);
      return Right(token);
    }
    catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updateFreelancer(FreelancerEntity freelancerEntity) {
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, List<FreelancerEntity>>> searchFreelancers(String searchQuery) async {
    try {
      final freelancers = await _freelancerRemoteDataSource.searchFreelancers(searchQuery);
      return Right(freelancers);
    }
    catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }
}