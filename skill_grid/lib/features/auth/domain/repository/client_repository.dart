import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';

abstract interface class IClientRepository {
  Future<Either<Failure, void>> registerClient(ClientEntity clientEntity);
  Future<Either<Failure, void>> deleteClient(String clientId);
  Future<Either<Failure, ClientEntity>> getClientById(String clientId);
  Future<Either<Failure, String>> loginClient(String email, String password);
}