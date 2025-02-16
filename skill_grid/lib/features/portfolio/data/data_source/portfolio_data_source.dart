import 'package:skill_grid/features/portfolio/domain/entity/portfolio_entity.dart';

abstract interface class IPortfolioDataSource {
  Future<PortfolioEntity> getPortfolioByFreelancerServiceId(String freelancerServiceId);
  Future<List<PortfolioEntity>> getPortfolioByFreelancerId(String freelancerId);
}