import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/repository/client_repository.dart';

class SendOtpParams extends Equatable {
  final String email;
  const SendOtpParams({required this.email});

  @override
  List<Object?> get props => [email];
}

class SendOtpUseCase implements UsecaseWithParams<void, SendOtpParams> {
  final IClientRepository clientRepository;
  SendOtpUseCase({required this.clientRepository});

  @override
  Future<Either<Failure, void>> call(SendOtpParams params) async {
    return await clientRepository.sendOtp(params.email);
  }
}
