import 'package:dio/dio.dart';
import 'package:skill_grid/app/constants/api_endpoints.dart';
import 'package:skill_grid/features/auth/data/data_source/client_data_source.dart';
import 'package:skill_grid/features/auth/data/dto/find_client_by_id_dto.dart';
import 'package:skill_grid/features/auth/data/dto/login_dto.dart';
import 'package:skill_grid/features/auth/data/model/client_model/client_api_model.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';

class ClientRemoteDataSource implements IClientDataSource {
  final Dio _dio;
  ClientRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<void> registerClient(ClientEntity clientEntity) async {
    try {
      Response response = await _dio.post(ApiEndpoints.registerClient, data: {
        "first_name": clientEntity.firstName,
        "last_name": clientEntity.lastName,
        "mobile_no": clientEntity.mobileNo,
        "city": clientEntity.city,
        "email": clientEntity.email,
        "password": clientEntity.password,
        "profile_picture": clientEntity.profilePicture,
        "role": clientEntity.role
      });
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
  Future<void> deleteClient(String clientId) {
    // TODO: implement deleteClient
    throw UnimplementedError();
  }

  @override
  Future<ClientEntity> getClientById(String clientId) async {
    try {
      var response = await _dio.get(ApiEndpoints.findClientById,
          queryParameters: {'clientId': clientId});

      if (response.statusCode == 200) {
        FindClientByIdDto findClientByIdDto = FindClientByIdDto.fromJson(response.data);

        ClientEntity clientEntity = ClientApiModel.toEntity(findClientByIdDto);

        return clientEntity;
      } 
      else {
        throw Exception(response.statusMessage);
      }
    } 
    on DioException catch(e) {
      throw Exception(e);
    } 
    catch (e) {
      throw Exception('Error occurred while fetching client: $e');
    }
  }

  @override
  Future<String> loginClient(String email, String password) async {
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
}
