import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/data/data_source/remote_data_source/client_remote_data_source.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/repository/client_repository.dart';

class ClientRemoteRepository implements IClientRepository {
  final ClientRemoteDataSource _clientRemoteDataSource;

  ClientRemoteRepository(
      {required ClientRemoteDataSource clientRemoteDataSource})
      : _clientRemoteDataSource = clientRemoteDataSource;

  @override
  Future<Either<Failure, void>> registerClient(
      ClientEntity clientEntity) async {
    try {
      _clientRemoteDataSource.registerClient(clientEntity);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteClient(String clientId) {
    // TODO: implement deleteClient
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ClientEntity>> getClientById(String clientId) async {
    try {
      final client = await _clientRemoteDataSource.getClientById(clientId);
      return Right(client);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginClient(
      String email, String password) async {
    try {
      final token = await _clientRemoteDataSource.loginClient(email, password);
      return Right(token);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
