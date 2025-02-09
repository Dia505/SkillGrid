import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/freelancer_service/data/data_source/remote_data_source/freelancer_service_remote_data_source.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';
import 'package:skill_grid/features/freelancer_service/domain/repository/freelancer_service_repository.dart';

class FreelancerServiceRemoteRepository implements IFreelancerServiceRepository {
  final FreelancerServiceRemoteDataSource _freelancerServiceRemoteDataSource;
  FreelancerServiceRemoteRepository({required FreelancerServiceRemoteDataSource freelancerServiceRemoteDataSource})
    : _freelancerServiceRemoteDataSource = freelancerServiceRemoteDataSource;

  @override
  Future<Either<Failure, List<FreelancerServiceEntity>>> getFreelancerServiceByFreelancerId(String freelancerId) async {
    try {
      final freelancerServiceList = await _freelancerServiceRemoteDataSource.getFreelancerServiceByFreelancerId(freelancerId);
      return Right(freelancerServiceList);
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