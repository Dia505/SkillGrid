import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/repository/client_repository.dart';

class ClientUploadImageParams {
  final File file;

  const ClientUploadImageParams({
    required this.file
  });
}

class ClientUploadImageUseCase implements UsecaseWithParams<String, ClientUploadImageParams> {
  final IClientRepository _clientRepository;

  ClientUploadImageUseCase(this._clientRepository);

  @override
  Future<Either<Failure, String>> call(ClientUploadImageParams params) {
    return _clientRepository.uploadProfilePicture(params.file);
  }
}