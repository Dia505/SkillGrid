import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/repository/client_repository.dart';

class VerifyOtpParams extends Equatable {
  final String email;
  final String otp;

  const VerifyOtpParams({required this.email, required this.otp});

  @override
  List<Object?> get props => [email, otp];
}

class VerifyOtpUseCase implements UsecaseWithParams<void, VerifyOtpParams> {
  final IClientRepository clientRepository;
  VerifyOtpUseCase({required this.clientRepository});

  @override
  Future<Either<Failure, void>> call(VerifyOtpParams params) async {
    return await clientRepository.verifyOtp(params.email, params.otp);
  }
}
