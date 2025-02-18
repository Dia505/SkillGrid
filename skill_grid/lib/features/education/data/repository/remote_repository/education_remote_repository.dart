import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/education/data/data_source/remote_data_source/education_remote_data_source.dart';
import 'package:skill_grid/features/education/domain/entity/education_entity.dart';
import 'package:skill_grid/features/education/domain/repository/education_repository.dart';

class EducationRemoteRepository implements IEducationRepository {
  final EducationRemoteDataSource _educationRemoteDataSource;
  EducationRemoteRepository(
      {required EducationRemoteDataSource educationRemoteDataSource})
      : _educationRemoteDataSource = educationRemoteDataSource;

  @override
  Future<Either<Failure, List<EducationEntity>>> getEducationByFreelancerId(
      String freelancerId, String? token) async {
    try {
      final educationList = await _educationRemoteDataSource
          .getEducationByFreelancerId(freelancerId, token);
      return Right(educationList);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
