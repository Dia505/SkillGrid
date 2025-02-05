import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';

abstract interface class IClientRepository {
  Future<Either<Failure, void>> registerClient(ClientEntity clientEntity);
  Future<Either<Failure, void>> deleteClient(String clientId);
  Future<Either<Failure, ClientEntity>> getClientById(String clientId, String? token);
  Future<Either<Failure, String>> loginClient(String email, String password);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
  Future<Either<Failure, String>> updateProfilePicture(String clientId, File file, String? token);
}