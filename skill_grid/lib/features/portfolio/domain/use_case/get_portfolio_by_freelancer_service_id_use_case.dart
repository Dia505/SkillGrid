import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/portfolio/domain/entity/portfolio_entity.dart';
import 'package:skill_grid/features/portfolio/domain/repository/portfolio_repository.dart';

class GetPortfolioByFreelancerServiceIdParams {
  final String freelancerServiceId;
  GetPortfolioByFreelancerServiceIdParams({
    required this.freelancerServiceId
  });
}

class GetPortfolioByFreelancerServiceIdUseCase implements UsecaseWithParams<PortfolioEntity, GetPortfolioByFreelancerServiceIdParams> {
  final IPortfolioRepository portfolioRepository;
  GetPortfolioByFreelancerServiceIdUseCase({required this.portfolioRepository});

  @override
  Future<Either<Failure, PortfolioEntity>> call(GetPortfolioByFreelancerServiceIdParams params) {
    return portfolioRepository.getPortfolioByFreelancerServiceId(params.freelancerServiceId);
  }
}