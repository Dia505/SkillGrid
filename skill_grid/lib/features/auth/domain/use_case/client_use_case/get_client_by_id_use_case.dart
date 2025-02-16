import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/repository/client_repository.dart';

class GetClientByIdParams {
  final String clientId;
  GetClientByIdParams({required this.clientId});
}

class GetClientByIdUseCase implements UsecaseWithParams<ClientEntity, GetClientByIdParams> {
  final IClientRepository clientRepository;
  final TokenSharedPrefs tokenSharedPrefs;
  final TokenHelper tokenHelper;
  GetClientByIdUseCase({
    required this.clientRepository,
    required this.tokenSharedPrefs,
    required this.tokenHelper
  });

  @override
  Future<Either<Failure, ClientEntity>> call(GetClientByIdParams params) async {
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
       return Left(l);
    }, 
    
    (r) async {
      final role = await tokenHelper.getRoleFromToken();
      if(role == "client") {
        return clientRepository.getClientById(params.clientId, r);
      }
      else {
        return const Left(RoleMismatchFailure(message: "Access denied. You have to be a client"));
      }
    });
  }
}