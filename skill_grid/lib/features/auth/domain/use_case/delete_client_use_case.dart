import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/repository/client_repository.dart';

class DeleteClientParams {
  final String clientId;
  DeleteClientParams({required this.clientId});
}

class DeleteClientUseCase implements UsecaseWithParams<void, DeleteClientParams> {
  final IClientRepository clientRepository;
  DeleteClientUseCase({required this.clientRepository});

  @override
  Future<Either<Failure, void>> call(DeleteClientParams params) {
    return clientRepository.deleteClient(params.clientId);
  }
}