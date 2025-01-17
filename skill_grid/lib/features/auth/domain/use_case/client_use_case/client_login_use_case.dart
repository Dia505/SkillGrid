import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/repository/client_repository.dart';

class ClientLoginParams extends Equatable {
  final String email;
  final String password;

  const ClientLoginParams({
    required this.email,
    required this.password
  });

  const ClientLoginParams.initial()
    : email = "",
      password = "";

  @override
  List<Object?> get props => [email, password];
}

class ClientLoginUseCase implements UsecaseWithParams<String, ClientLoginParams> {
  final IClientRepository clientRepository;
  ClientLoginUseCase(this.clientRepository);

  @override
  Future<Either<Failure, String>> call(ClientLoginParams params) {
    return clientRepository.loginClient(params.email, params.password);
  }
}