import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/freelancer_service/data/data_source/local_data_source/freelancer_service_local_data_source.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';
import 'package:skill_grid/features/freelancer_service/domain/repository/freelancer_service_repository.dart';

class FreelancerServiceLocalRepository implements IFreelancerServiceRepository {
  final FreelancerServiceLocalDataSource _freelancerServiceLocalDataSource;
  FreelancerServiceLocalRepository(
      {required FreelancerServiceLocalDataSource
          freelancerServiceLocalDataSource})
      : _freelancerServiceLocalDataSource = freelancerServiceLocalDataSource;

  @override
  Future<Either<Failure, List<FreelancerServiceEntity>>>
      getFreelancerServiceByFreelancerId(String freelancerId) async {
    try {
      final freelancerServiceList = await _freelancerServiceLocalDataSource
          .getFreelancerServiceByFreelancerId(freelancerId);
      return Right(freelancerServiceList);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
