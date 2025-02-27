import 'dart:io';

import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';

abstract interface class IClientDataSource {
  Future<void> registerClient(ClientEntity clientEntity);
  Future<void> deleteClient(String clientId, String?token);
  Future<ClientEntity> getClientById(String clientId, String? token);
  Future<String> loginClient(String email, String password);
  Future<String> updateProfilePicture(String clientId, File file, String? token);
  Future<void> updateClient(String clientId, ClientEntity updatedClient, String? token);
  Future<void> sendOtp(String email);
  Future<void> verifyOtp(String email, String otp);
  Future<void> resetPassword(String email, String otp, String newPassword);
}
