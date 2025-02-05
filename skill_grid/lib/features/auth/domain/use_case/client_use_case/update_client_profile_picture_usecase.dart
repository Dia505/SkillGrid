import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/auth/domain/repository/client_repository.dart';

class UpdateClientProfilePictureParams {
  final String clientId;
  final File file;

  UpdateClientProfilePictureParams(
      {required this.clientId, required this.file});
}

class UpdateClientProfilePictureUsecase implements UsecaseWithParams<String, UpdateClientProfilePictureParams> {
  final IClientRepository clientRepository;
  final TokenSharedPrefs tokenSharedPrefs;
  final TokenHelper tokenHelper;
  
  UpdateClientProfilePictureUsecase({
    required this.clientRepository,
    required this.tokenSharedPrefs,
    required this.tokenHelper
  });

  @override
  Future<Either<Failure, String>> call(UpdateClientProfilePictureParams params) async {
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
       return Left(l);
    }, 
    (r) async {
      final role = await tokenHelper.getRoleFromToken();
      if(role == "client") {
        return clientRepository.updateProfilePicture(params.clientId, params.file, r);
      }
      else {
        return const Left(RoleMismatchFailure(message: "Access denied. You have to be a client"));
      }
    });
  }
}

