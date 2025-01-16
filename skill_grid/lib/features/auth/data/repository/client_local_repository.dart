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
  Future<Either<Failure, void>> deleteClient(String clientId) async {
    try {
      await _clientLocalDataSource.deleteClient(clientId);
      return const Right(null);
    }
    catch (e) {
      return Left(LocalDatabaseFailure(message: "Error deleting client: $e"));
    }
  }

  @override
  Future<Either<Failure, ClientEntity>> getClientById(String clientId) async {
    try {
      final clientEntity = await _clientLocalDataSource.getClientById(clientId);
      return Right(clientEntity);
    }
    catch (e) {
      return Left(LocalDatabaseFailure(message: "Error getting client information: $e"));
    }
  }
}
