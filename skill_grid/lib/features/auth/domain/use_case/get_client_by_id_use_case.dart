import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/repository/client_repository.dart';

class GetClientByIdParams {
  final String clientId;
  GetClientByIdParams({required this.clientId});
}

class GetClientByIdUseCase implements UsecaseWithParams<ClientEntity, GetClientByIdParams> {
  final IClientRepository clientRepository;
  GetClientByIdUseCase({required this.clientRepository});

  @override
  Future<Either<Failure, ClientEntity>> call(GetClientByIdParams params) {
    return clientRepository.getClientById(params.clientId);
  }
}