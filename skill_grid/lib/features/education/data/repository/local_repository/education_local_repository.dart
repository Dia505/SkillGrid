import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/education/data/data_source/local_data_source/education_local_data_source.dart';
import 'package:skill_grid/features/education/domain/entity/education_entity.dart';
import 'package:skill_grid/features/education/domain/repository/education_repository.dart';

class EducationLocalRepository implements IEducationRepository {
  final EducationLocalDataSource _educationLocalDataSource;
  EducationLocalRepository({required EducationLocalDataSource educationLocalDataSource})
    : _educationLocalDataSource = educationLocalDataSource;


  @override
  Future<Either<Failure, List<EducationEntity>>> getEducationByFreelancerId(String freelancerId, String? token) async {
    try {
      final educationList = await _educationLocalDataSource
          .getEducationByFreelancerId(freelancerId, token);
      return Right(educationList);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }}