import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/repository/client_repository.dart';

class UpdateClientParams extends Equatable {
  final String clientId;
  final String? firstName;
  final String? lastName;
  final String? mobileNo;
  final String? city;
  final String? email;
  final String? password;

  const UpdateClientParams(
      {required this.clientId,
      this.firstName,
      this.lastName,
      this.mobileNo,
      this.city,
      this.email,
      this.password});

  @override
  List<Object?> get props =>
      [clientId, firstName, lastName, mobileNo, city, email, password];
}

class UpdateClientUseCase implements UsecaseWithParams<void, UpdateClientParams> {
  final IClientRepository clientRepository;
  final TokenSharedPrefs tokenSharedPrefs;
  final TokenHelper tokenHelper;

  UpdateClientUseCase({
    required this.clientRepository,
    required this.tokenSharedPrefs,
    required this.tokenHelper,
  });

  @override
  Future<Either<Failure, void>> call(UpdateClientParams params) async {
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      final role = await tokenHelper.getRoleFromToken();
      if (role == "client") {
        // Fetch the existing client data first
        final existingClient = await clientRepository.getClientById(params.clientId, r);
        return existingClient.fold(
          (failure) => Left(failure),
          (currentClient) async {
            final updatedClient = ClientEntity(
              clientId: params.clientId,
              firstName: params.firstName ?? currentClient.firstName,
              lastName: params.lastName ?? currentClient.lastName,
              mobileNo: params.mobileNo ?? currentClient.mobileNo,
              city: params.city ?? currentClient.city,
              email: params.email ?? currentClient.email,
              password: params.password ?? currentClient.password,
            );
            return clientRepository.updateClient(params.clientId, updatedClient, r);
          },
        );
      } else {
        return const Left(RoleMismatchFailure(message: "Access denied. You have to be a client"));
      }
    });
  }
}

