import 'package:skill_grid/core/network/hive_service.dart';
import 'package:skill_grid/features/portfolio/data/data_source/portfolio_data_source.dart';
import 'package:skill_grid/features/portfolio/domain/entity/portfolio_entity.dart';

class PortfolioLocalDataSource implements IPortfolioDataSource {
  final HiveService _hiveService;
  PortfolioLocalDataSource({required HiveService hiveService})
    : _hiveService = hiveService;

  @override
  Future<List<PortfolioEntity>> getPortfolioByFreelancerId(String freelancerId) {
    try {
      return _hiveService.getPortfolioByFreelancerId(freelancerId).then((value) {
        return value.map((e) => e.toEntity()).toList();
      });
    }
    catch (e) {
      throw Exception("Error retrieving the freelancer's portfolio: $e");
    }
  }

  @override
  Future<PortfolioEntity> getPortfolioByFreelancerServiceId(String freelancerServiceId) async {
    try {
      final portfolioHiveModel = await _hiveService.getPortfolioByFreelancerServiceId(freelancerServiceId);
      return portfolioHiveModel.toEntity();
    }
    catch (e) {
      throw Exception("Error retrieving the freelancer-service's portfolio: $e");
    }
  }  
}