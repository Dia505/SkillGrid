import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/network/network_info.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/repository/client_repository.dart';

class GetClientByIdParams {
  final String clientId;
  GetClientByIdParams({required this.clientId});
}

class GetClientByIdUseCase
    implements UsecaseWithParams<ClientEntity, GetClientByIdParams> {
  final IClientRepository clientRemoteRepository;
  final IClientRepository clientLocalRepoitory;
  final TokenSharedPrefs tokenSharedPrefs;
  final TokenHelper tokenHelper;
  final NetworkInfo networkInfo;
  GetClientByIdUseCase(
      {required this.clientRemoteRepository,
      required this.clientLocalRepoitory,
      required this.tokenSharedPrefs,
      required this.tokenHelper,
      required this.networkInfo});

  @override
  Future<Either<Failure, ClientEntity>> call(GetClientByIdParams params) async {
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      final role = await tokenHelper.getRoleFromToken();
      if (role == "client") {
        final isConnected = await networkInfo.isConnected;
        print("Network connected: $isConnected");
        if (await networkInfo.isConnected) {
          // Online: Fetch from API and cache locally
          final result =
              await clientRemoteRepository.getClientById(params.clientId, r);
          result.fold((failure) => null, (client) async {
            await clientLocalRepoitory
                .registerClient(client); // Save to local Hive
          });
          return result;
        } else {
          // Offline: Fetch from local Hive
          return clientLocalRepoitory.getClientById(params.clientId, r);
        }
      } else {
        return const Left(RoleMismatchFailure(
            message: "Access denied. You have to be a client"));
      }
    });
  }
}
