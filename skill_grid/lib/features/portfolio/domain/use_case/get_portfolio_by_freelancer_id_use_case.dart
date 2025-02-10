import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/portfolio/domain/entity/portfolio_entity.dart';
import 'package:skill_grid/features/portfolio/domain/repository/portfolio_repository.dart';

class GetPortfolioByFreelancerIdParams {
  final String freelancerId;
  GetPortfolioByFreelancerIdParams({
    required this.freelancerId
  });
}

class GetPortfolioByFreelancerIdUseCase implements UsecaseWithParams<List<PortfolioEntity>, GetPortfolioByFreelancerIdParams> {
  final IPortfolioRepository portfolioRepository;
  GetPortfolioByFreelancerIdUseCase({required this.portfolioRepository});

  @override
  Future<Either<Failure, List<PortfolioEntity>>> call(GetPortfolioByFreelancerIdParams params) {
    return portfolioRepository.getPortfolioByFreelancerId(params.freelancerId);
  }
}