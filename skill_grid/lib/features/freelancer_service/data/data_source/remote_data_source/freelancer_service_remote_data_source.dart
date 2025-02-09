import 'package:dio/dio.dart';
import 'package:skill_grid/app/constants/api_endpoints.dart';
import 'package:skill_grid/features/freelancer_service/data/data_source/freelancer_service_data_source.dart';
import 'package:skill_grid/features/freelancer_service/data/dto/get_freelancer_service_by_freelancer_id_dto.dart';
import 'package:skill_grid/features/freelancer_service/data/model/freelancer_service_api_model.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';

class FreelancerServiceRemoteDataSource
    implements IFreelancerServiceDataSource {
  final Dio _dio;
  FreelancerServiceRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<FreelancerServiceEntity>> getFreelancerServiceByFreelancerId(
      String freelancerId) async {
    try {
      final String url =
          "${ApiEndpoints.getFreelancerServiceByFreelancerId}/$freelancerId";
      var response = await _dio.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        List<GetFreelancerServiceByFreelancerIdDto> freelancerServiceDto = data
            .map((json) => GetFreelancerServiceByFreelancerIdDto.fromJson(json))
            .toList();

        List<FreelancerServiceApiModel> freelancerServiceApiModels =
            freelancerServiceDto
                .map((dto) => FreelancerServiceApiModel.fromDto(dto))
                .toList();

        return FreelancerServiceApiModel.toEntityList(
            freelancerServiceApiModels);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("An error occurred: ${e.toString()}");
    }
  }
}
