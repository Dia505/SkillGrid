import 'dart:io';

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
  Future<ClientEntity> getClientById(String clientId, String? token) async {
    try {
      final String url = "${ApiEndpoints.findClientById}/$clientId";

      var response = await _dio.get(url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        FindClientByIdDto findClientByIdDto =
            FindClientByIdDto.fromJson(response.data);

        ClientEntity clientEntity = ClientApiModel.toEntity(findClientByIdDto);

        return clientEntity;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
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

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split("/").last;
      FormData formData = FormData.fromMap({
        "profile_picture":
            await MultipartFile.fromFile(file.path, filename: fileName)
      });

      Response response =
          await _dio.post(ApiEndpoints.uploadProfilePicture, data: formData);

      if (response.statusCode == 200) {
        return response.data["data"];
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
  Future<String> updateProfilePicture(
      String clientId, File file, String? token) async {
    try {
      final String url =
          "${ApiEndpoints.updateClientProfilePicture}/$clientId/profile-picture";
      String fileName = file.path.split("/").last;

      FormData formData = FormData.fromMap({
        "profile_picture":
            await MultipartFile.fromFile(file.path, filename: fileName),
      });

      Response response = await _dio.put(
        url,
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data["profile_picture"];
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
  Future<void> updateClient(
      String clientId, ClientEntity updatedClient, String? token) async {
    try {
      final String url = "${ApiEndpoints.updateClient}/$clientId";
      Map<String, dynamic> updateData = {};

    // Get the current client data from the database or API
    final currentClient = await _dio.get("${ApiEndpoints.findClientById}/$clientId",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ));
    
    final currentClientData = currentClient.data;

    // Update only the fields that have actually changed
    if (updatedClient.firstName != currentClientData['first_name']) {
      updateData["first_name"] = updatedClient.firstName;
    }
    if (updatedClient.lastName != currentClientData['last_name']) {
      updateData["last_name"] = updatedClient.lastName;
    }
    if (updatedClient.mobileNo != currentClientData['mobile_no']) {
      updateData["mobile_no"] = updatedClient.mobileNo;
    }
    if (updatedClient.city != currentClientData['city']) {
      updateData["city"] = updatedClient.city;
    }
    if (updatedClient.email != currentClientData['email']) {
      updateData["email"] = updatedClient.email;
    }
    if (updatedClient.password != currentClientData['password']) {
      updateData["password"] = updatedClient.password;
    }

    // Proceed to update only changed fields
    if (updateData.isNotEmpty) {
      var response = await _dio.put(url,
          data: updateData,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        print("Client updated successfully.");
      } else {
        throw Exception(response.statusMessage);
      }
    }} on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
