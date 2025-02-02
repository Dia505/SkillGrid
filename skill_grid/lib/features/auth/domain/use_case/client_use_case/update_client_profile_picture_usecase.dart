import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/repository/client_repository.dart';

class UpdateClientProfilePictureParams {
  final String clientId;
  final File file;
  final String token;

  UpdateClientProfilePictureParams(
      {required this.clientId, required this.file, required this.token});
}

class UpdateClientProfilePictureUsecase
    implements UsecaseWithParams<String, UpdateClientProfilePictureParams> {
  final IClientRepository clientRepository;
  
  UpdateClientProfilePictureUsecase({required this.clientRepository});

  @override
  Future<Either<Failure, String>> call(UpdateClientProfilePictureParams params) {
    return clientRepository.updateProfilePicture(
      params.clientId, 
      params.file, 
      params.token, 
    );
  }
}

