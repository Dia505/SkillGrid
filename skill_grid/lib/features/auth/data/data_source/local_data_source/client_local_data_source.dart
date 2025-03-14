import 'dart:io';

import 'package:skill_grid/core/network/hive_service.dart';
import 'package:skill_grid/features/auth/data/data_source/client_data_source.dart';
import 'package:skill_grid/features/auth/data/model/client_model/client_hive_model.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';

class ClientLocalDataSource implements IClientDataSource {
  final HiveService _hiveService;
  ClientLocalDataSource({required HiveService hiveService})
      : _hiveService = hiveService;

  @override
  Future<void> registerClient(ClientEntity clientEntity) async {
    try {
      final clientHiveModel = ClientHiveModel.fromEntity(clientEntity);
      await _hiveService.registerClient(clientHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteClient(String clientId, String? token) async {
    try {
      await _hiveService.deleteClient(clientId);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ClientEntity> getClientById(String clientId, String? token) async {
    try {
      final clientHiveModel = await _hiveService.getClientById(clientId);
      return clientHiveModel!.toEntity();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> loginClient(String email, String password) async {
    try {
      await _hiveService.loginClient(email, password);
      return Future.value("Success");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<String> updateProfilePicture(
      String clientId, File file, String? token) async {
    try {
      final clientHiveModel = await _hiveService.getClientById(clientId);

      if (clientHiveModel == null) {
        throw Exception("Client not found");
      }

      // Directly update the profile picture using the file path
      await _hiveService.updateClientProfilePicture(clientId, file.path);

      return file.path;
    } catch (e) {
      throw Exception("Failed to update profile picture: $e");
    }
  }

  @override
  Future<void> updateClient(
      String clientId, ClientEntity updatedClient, String? token) async {
    try {
      final clientHiveModel = await _hiveService.getClientById(clientId);

      if (clientHiveModel == null) {
        throw Exception("Client not found");
      }

      await _hiveService.updateClient(clientId,
          newFirstName: updatedClient.firstName,
          newLastName: updatedClient.lastName,
          newMobileNo: updatedClient.mobileNo,
          newCity: updatedClient.city,
          newEmail: updatedClient.email,
          newPassword: updatedClient.password);
    } catch (e) {
      throw Exception("Failed to update client data: $e");
    }
  }
  
  @override
  Future<void> sendOtp(String email) {
    throw UnimplementedError();
  }
  
  @override
  Future<void> resetPassword(String email, String otp, String newPassword) {
    throw UnimplementedError();
  }
  
  @override
  Future<void> verifyOtp(String email, String otp) {
    throw UnimplementedError();
  }
}
