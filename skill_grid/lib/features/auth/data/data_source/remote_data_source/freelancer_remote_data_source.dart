import 'package:dio/dio.dart';
import 'package:skill_grid/app/constants/api_endpoints.dart';
import 'package:skill_grid/features/auth/data/data_source/freelancer_data_source.dart';
import 'package:skill_grid/features/auth/data/dto/find_freelancer_by_id_dto.dart';
import 'package:skill_grid/features/auth/data/dto/login_dto.dart';
import 'package:skill_grid/features/auth/data/model/freelancer_model/freelancer_api_model.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';

class FreelancerRemoteDataSource implements IFreelancerDataSource {
  final Dio _dio;
  FreelancerRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<void> registerFreelancer(FreelancerEntity freelancerEntity) async {
    try {
      // Prepare the data to send to the API
      Map<String, dynamic> data = {
        "first_name": freelancerEntity.firstName,
        "last_name": freelancerEntity.lastName,
        "date_of_birth": freelancerEntity.dateOfBirth.toIso8601String(),
        "mobile_no": freelancerEntity.mobileNo,
        "address": freelancerEntity.address,
        "city": freelancerEntity.city,
        "email": freelancerEntity.email,
        "password": freelancerEntity.password
      };

      // Send the data to the API
      Response response =
          await _dio.post(ApiEndpoints.registerFreelancer, data: data);

      print("Response: $response");

      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteFreelancer(String freelancerId) {
    // TODO: implement deleteFreelancer
    throw UnimplementedError();
  }

  @override
  Future<List<FreelancerEntity>> getAllFreelancers() {
    // TODO: implement getAllFreelancers
    throw UnimplementedError();
  }

  @override
  Future<FreelancerEntity> getFreelancerById(
      String freelancerId, String? token) async {
    try {
      final String url = "${ApiEndpoints.findFreelancerById}/$freelancerId";

      var response = await _dio.get(url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        FindFreelancerByIdDto findFreelancerByIdDto =
            FindFreelancerByIdDto.fromJson(response.data);

        FreelancerEntity freelancerEntity = FreelancerApiModel.toEntity(findFreelancerByIdDto);

        return freelancerEntity;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception('Error occurred while fetching freelancer: $e');
    }
  }

  @override
  Future<String> loginFreelancer(String email, String password) async {
    try {
      Response response = await _dio.post(ApiEndpoints.login,
          data: {"email": email, "password": password});
      if (response.statusCode == 200) {
        LoginDto loginDto = LoginDto.fromJson(response.data);
        return loginDto.token;
      } else {
        throw Exception("Login failed: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("An error occurred: ${e.toString()}");
    }
  }

  @override
  Future<void> updateFreelancer(FreelancerEntity freelancerEntity) {
    // TODO: implement updateFreelancer
    throw UnimplementedError();
  }
}
