import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/repository/freelancer_repository.dart';

class FreelancerLoginParams extends Equatable {
  final String email;
  final String password;

  const FreelancerLoginParams({
    required this.email,
    required this.password
  });

  const FreelancerLoginParams.initial()
    : email = "",
      password = "";

  @override
  List<Object?> get props => [email, password];
}

class FreelancerLoginUseCase implements UsecaseWithParams<String, FreelancerLoginParams> {
  final IFreelancerRepository freelancerRepository;
  FreelancerLoginUseCase(this.freelancerRepository);

  @override
  Future<Either<Failure, String>> call(FreelancerLoginParams params) {
    return freelancerRepository.loginFreelancer(params.email, params.password);
  }
}