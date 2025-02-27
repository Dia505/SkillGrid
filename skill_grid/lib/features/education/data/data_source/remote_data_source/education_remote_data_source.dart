import 'package:dio/dio.dart';
import 'package:skill_grid/app/constants/api_endpoints.dart';
import 'package:skill_grid/features/education/data/data_source/education_data_source.dart';
import 'package:skill_grid/features/education/data/dto/get_education_by_freelancer_id_dto.dart';
import 'package:skill_grid/features/education/data/model/education_api_model.dart';
import 'package:skill_grid/features/education/domain/entity/education_entity.dart';

class EducationRemoteDataSource implements IEducationDataSource {
  final Dio _dio;
  EducationRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<EducationEntity>> getEducationByFreelancerId(String freelancerId, String? token) async {
    try {
      final String url = "${ApiEndpoints.getEducationByFreelancerId}/$freelancerId";

      var response = await _dio.get(url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        List<GetEducationByFreelancerIdDto> educationDto = data
            .map((json) => GetEducationByFreelancerIdDto.fromJson(json))
            .toList();

        List<EducationApiModel> educationApiModels =
            educationDto
                .map((dto) => EducationApiModel.fromDto(dto))
                .toList();

        return EducationApiModel.toEntityList(
            educationApiModels);
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