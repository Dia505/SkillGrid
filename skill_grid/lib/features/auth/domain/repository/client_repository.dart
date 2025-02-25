import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';

abstract interface class IClientRepository {
  Future<Either<Failure, void>> registerClient(ClientEntity clientEntity);
  Future<Either<Failure, void>> deleteClient(String clientId, String? token);
  Future<Either<Failure, ClientEntity>> getClientById(String clientId, String? token);
  Future<Either<Failure, String>> loginClient(String email, String password);
  Future<Either<Failure, String>> updateProfilePicture(String clientId, File file, String? token);
  Future<Either<Failure, void>> updateClient(String clientId, ClientEntity updatedClient, String? token);
  Future<Either<Failure, void>> sendOtp(String email);
  Future<Either<Failure, void>> verifyOtp(String email, String otp);
  Future<Either<Failure, void>> resetPassword(String email, String otp, String newPassword);
}