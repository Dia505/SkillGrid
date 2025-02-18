import 'package:dio/dio.dart';
import 'package:skill_grid/app/constants/api_endpoints.dart';
import 'package:skill_grid/features/employment/data/data_source/employment_data_source.dart';
import 'package:skill_grid/features/employment/data/dto/get_employment_by_freelacer_id_dto.dart';
import 'package:skill_grid/features/employment/data/model/employment_api_model.dart';
import 'package:skill_grid/features/employment/domain/entity/employment_entity.dart';

class EmploymentRemoteDataSource implements IEmploymentDataSource {
  final Dio _dio;
  EmploymentRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<EmploymentEntity>> getEmploymentByFreelancerId(
      String freelancerId, String? token) async {
    try {
      final String url =
          "${ApiEndpoints.getEmploymentByFreelancerId}/$freelancerId";

      var response = await _dio.get(url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        List<GetEmploymentByFreelacerIdDto> employmentDto = data
            .map((json) => GetEmploymentByFreelacerIdDto.fromJson(json))
            .toList();

        List<EmploymentApiModel> employmentApiModels = employmentDto
            .map((dto) => EmploymentApiModel.fromDto(dto))
            .toList();

        return EmploymentApiModel.toEntityList(employmentApiModels);
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
