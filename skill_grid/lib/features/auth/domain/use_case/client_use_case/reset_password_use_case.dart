import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/repository/client_repository.dart';

class ResetPasswordParams extends Equatable {
  final String email;
  final String otp;
  final String newPassword;

  const ResetPasswordParams(
      {required this.email, required this.otp, required this.newPassword});

  @override
  List<Object?> get props => [email, otp, newPassword];
}

class ResetPasswordUseCase
    implements UsecaseWithParams<void, ResetPasswordParams> {
  final IClientRepository clientRepository;
  ResetPasswordUseCase({required this.clientRepository});

  @override
  Future<Either<Failure, void>> call(ResetPasswordParams params) async {
    return await clientRepository.resetPassword(
        params.email, params.otp, params.newPassword);
  }
}
