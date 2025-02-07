import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/repository/client_repository.dart';

class DeleteClientParams {
  final String clientId;
  DeleteClientParams({required this.clientId});
}

class DeleteClientUseCase implements UsecaseWithParams<void, DeleteClientParams> {
  final IClientRepository clientRepository;
  final TokenSharedPrefs tokenSharedPrefs;
  DeleteClientUseCase({required this.clientRepository, required this.tokenSharedPrefs});

  @override
  Future<Either<Failure, void>> call(DeleteClientParams params) async {
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return await clientRepository.deleteClient(params.clientId, r);
    });
  }
}