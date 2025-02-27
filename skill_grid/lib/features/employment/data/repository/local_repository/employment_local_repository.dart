import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/employment/data/data_source/local_data_source/employment_local_data_source.dart';
import 'package:skill_grid/features/employment/domain/entity/employment_entity.dart';
import 'package:skill_grid/features/employment/domain/repository/employment_repository.dart';

class EmploymentLocalRepository implements IEmploymentRepository {
  final EmploymentLocalDataSource _employmentLocalDataSource;
  EmploymentLocalRepository(
      {required EmploymentLocalDataSource employmentLocalDataSource})
      : _employmentLocalDataSource = employmentLocalDataSource;

  @override
  Future<Either<Failure, List<EmploymentEntity>>> getEmploymentByFreelancerId(
      String freelancerId, String? token) async {
    try {
      final employmentList = await _employmentLocalDataSource
          .getEmploymentByFreelancerId(freelancerId, token);
      return Right(employmentList);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
