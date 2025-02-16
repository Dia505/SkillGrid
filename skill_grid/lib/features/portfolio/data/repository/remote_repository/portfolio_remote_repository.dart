import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/portfolio/data/data_source/remote_data_source/portfolio_remote_data_source.dart';
import 'package:skill_grid/features/portfolio/domain/entity/portfolio_entity.dart';
import 'package:skill_grid/features/portfolio/domain/repository/portfolio_repository.dart';

class PortfolioRemoteRepository implements IPortfolioRepository {
  final PortfolioRemoteDataSource _portfolioRemoteDataSource;
  PortfolioRemoteRepository(
      {required PortfolioRemoteDataSource portfolioRemoteDataSource})
      : _portfolioRemoteDataSource = portfolioRemoteDataSource;

  @override
  Future<Either<Failure, List<PortfolioEntity>>> getPortfolioByFreelancerId(
      String freelancerId) async {
    try {
      final portfolioList = await _portfolioRemoteDataSource
          .getPortfolioByFreelancerId(freelancerId);
      return Right(portfolioList);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, PortfolioEntity>> getPortfolioByFreelancerServiceId(
      String freelancerServiceId) async {
    try {
      final portfolio = await _portfolioRemoteDataSource
          .getPortfolioByFreelancerServiceId(freelancerServiceId);
      print("repo, $portfolio");
      return Right(portfolio);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
