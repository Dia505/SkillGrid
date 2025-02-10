import 'package:dio/dio.dart';
import 'package:skill_grid/app/constants/api_endpoints.dart';
import 'package:skill_grid/features/portfolio/data/data_source/portfolio_data_source.dart';
import 'package:skill_grid/features/portfolio/data/dto/get_portfolio_by_freelancer_id_dto.dart';
import 'package:skill_grid/features/portfolio/data/dto/get_portfolio_by_freelancer_service_id_dto.dart';
import 'package:skill_grid/features/portfolio/data/model/portfolio_api_model.dart';
import 'package:skill_grid/features/portfolio/domain/entity/portfolio_entity.dart';

class PortfolioRemoteDataSource implements IPortfolioDataSource {
  final Dio _dio;
  PortfolioRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<PortfolioEntity>> getPortfolioByFreelancerId(
      String freelancerId) async {
    try {
      final String url =
          "${ApiEndpoints.getPortfolioByFreelancerId}/$freelancerId";
      var response = await _dio.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        List<GetPortfolioByFreelancerIdDto> portfolioDto = data
            .map((json) => GetPortfolioByFreelancerIdDto.fromJson(json))
            .toList();

        List<PortfolioApiModel> portfolioApiModels =
            portfolioDto.map((dto) => PortfolioApiModel.fromDto(dto)).toList();

        return PortfolioApiModel.toEntityList(portfolioApiModels);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("An error occurred: ${e.toString()}");
    }
  }

  @override
  Future<PortfolioEntity> getPortfolioByFreelancerServiceId(
      String freelancerServiceId) async {
    try {
      final String url =
          "${ApiEndpoints.getPortfolioByFreelancerServiceId}/$freelancerServiceId";
      var response = await _dio.get(url);

      if (response.statusCode == 200) {
        GetPortfolioByFreelancerServiceIdDto getPortfolioByFreelancerServiceIdDto =
            GetPortfolioByFreelancerServiceIdDto.fromJson(response.data);

        PortfolioEntity portfolioEntity =
            PortfolioApiModel.getPortfolioByFreelancerServiceIdDtoToEntity(getPortfolioByFreelancerServiceIdDto);

        return portfolioEntity;
      } else {
        throw Exception(response.statusMessage);
      }
    }
    on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("An error occurred: ${e.toString()}");
    }
  }
}
