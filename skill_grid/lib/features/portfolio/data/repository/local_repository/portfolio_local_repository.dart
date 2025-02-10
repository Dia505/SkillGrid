import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/portfolio/data/data_source/local_data_source/portfolio_local_data_source.dart';
import 'package:skill_grid/features/portfolio/domain/entity/portfolio_entity.dart';
import 'package:skill_grid/features/portfolio/domain/repository/portfolio_repository.dart';

class PortfolioLocalRepository implements IPortfolioRepository {
  final PortfolioLocalDataSource _portfolioLocalDataSource;
  PortfolioLocalRepository({required PortfolioLocalDataSource portfolioLocalDataSource})
    : _portfolioLocalDataSource = portfolioLocalDataSource;

  @override
  Future<Either<Failure, PortfolioEntity>> getPortfolioByFreelancerServiceId(String freelancerServiceId) async {
    try {
      final portfolioEntity = await _portfolioLocalDataSource.getPortfolioByFreelancerServiceId(freelancerServiceId);
      return Right(portfolioEntity);
    }
    catch (e) {
      return Left(LocalDatabaseFailure(
          message: "Error getting portfolio by freelancer service: $e"));
    }
  }

  @override
  Future<Either<Failure, List<PortfolioEntity>>> getPortfolioByFreelancerId(String freelancerId) async {
    try {
      final portfolioList = await _portfolioLocalDataSource.getPortfolioByFreelancerId(freelancerId);
      return Right(portfolioList);
    }
    catch (e) {
      return Left(LocalDatabaseFailure(
          message: "Error getting portfolio by freelancer: $e"));
    }
  }
}