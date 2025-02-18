import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/employment/data/data_source/remote_data_source/employment_remote_data_source.dart';
import 'package:skill_grid/features/employment/domain/entity/employment_entity.dart';
import 'package:skill_grid/features/employment/domain/repository/employment_repository.dart';

class EmploymentRemoteRepository implements IEmploymentRepository {
  final EmploymentRemoteDataSource _employmentRemoteDataSource;
  EmploymentRemoteRepository(
      {required EmploymentRemoteDataSource employmentRemoteDataSource})
      : _employmentRemoteDataSource = employmentRemoteDataSource;

  @override
  Future<Either<Failure, List<EmploymentEntity>>> getEmploymentByFreelancerId(
      String freelancerId, String? token) async {
    try {
      final employmentList = await _employmentRemoteDataSource
          .getEmploymentByFreelancerId(freelancerId, token);
      return Right(employmentList);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
