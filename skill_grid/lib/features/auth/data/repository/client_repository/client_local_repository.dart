import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/data/data_source/local_data_source/client_local_data_source.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/repository/client_repository.dart';

class ClientLocalRepository implements IClientRepository {
  final ClientLocalDataSource _clientLocalDataSource;
  ClientLocalRepository({required ClientLocalDataSource clientLocalDataSource})
      : _clientLocalDataSource = clientLocalDataSource;

  @override
  Future<Either<Failure, void>> registerClient(ClientEntity clientEntity) {
    try {
      _clientLocalDataSource.registerClient(clientEntity);
      return Future.value(const Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteClient(String clientId, String? token) async {
    try {
      await _clientLocalDataSource.deleteClient(clientId, token);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Error deleting client: $e"));
    }
  }

  @override
  Future<Either<Failure, ClientEntity>> getClientById(
      String clientId, String? token) async {
    try {
      final clientEntity =
          await _clientLocalDataSource.getClientById(clientId, token);
      return Right(clientEntity);
    } catch (e) {
      return Left(LocalDatabaseFailure(
          message: "Error getting client information: $e"));
    }
  }

  @override
  Future<Either<Failure, String>> loginClient(
      String email, String password) async {
    try {
      final token = await _clientLocalDataSource.loginClient(email, password);
      return Right(token);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateProfilePicture(
      String clientId, File file, String? token) async {
    try {
      final updatedImagePath = await _clientLocalDataSource
          .updateProfilePicture(clientId, file, token);
      return Right(updatedImagePath);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateClient(
      String clientId, ClientEntity updatedClient, String? token) async {
    try {
      await _clientLocalDataSource.updateClient(clientId, updatedClient, token);
      return const Right(null);
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }
  
  @override
  Future<Either<Failure, void>> resetPassword(String email, String otp, String newPassword) {
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, void>> sendOtp(String email) {
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, void>> verifyOtp(String email, String otp) {
    throw UnimplementedError();
  }
}
