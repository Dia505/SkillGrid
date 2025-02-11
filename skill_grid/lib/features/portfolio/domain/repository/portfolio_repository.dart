import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/portfolio/domain/entity/portfolio_entity.dart';

abstract interface class IPortfolioRepository {
  Future<Either<Failure, PortfolioEntity>> getPortfolioByFreelancerServiceId(String freelancerServiceId);
  Future<Either<Failure, List<PortfolioEntity>>> getPortfolioByFreelancerId(String freelancerId);
}