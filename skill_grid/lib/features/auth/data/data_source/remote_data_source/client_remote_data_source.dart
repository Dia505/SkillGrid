import 'package:dio/dio.dart';
import 'package:skill_grid/app/constants/api_endpoints.dart';
import 'package:skill_grid/features/auth/data/data_source/client_data_source.dart';
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
  Future<ClientEntity> getClientById(String clientId) {
    // TODO: implement getClientById
    throw UnimplementedError();
  }

  @override
  Future<String> loginClient(String email, String password) {
    // TODO: implement loginClient
    throw UnimplementedError();
  }

  
}