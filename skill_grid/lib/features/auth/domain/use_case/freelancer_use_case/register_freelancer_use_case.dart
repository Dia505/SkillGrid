import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_grid/app/use_case/use_case.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/repository/freelancer_repository.dart';

class CreateFreelancerParams extends Equatable {
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String mobileNo;
  final String address;
  final String city;
  final String email;
  final String password;

  const CreateFreelancerParams({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.mobileNo,
    required this.address,
    required this.city,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        dateOfBirth,
        mobileNo,
        address,
        city,
        email,
        password
      ];
}

class RegisterFreelancerUseCase implements UsecaseWithParams<void, CreateFreelancerParams> {
  final IFreelancerRepository freelancerRepository;
  RegisterFreelancerUseCase({required this.freelancerRepository});

  @override
  Future<Either<Failure, void>> call(CreateFreelancerParams params) async {
    return await freelancerRepository.registerFreelancer(
      FreelancerEntity(
        firstName: params.firstName, 
        lastName: params.lastName, 
        dateOfBirth: params.dateOfBirth,
        mobileNo: params.mobileNo, 
        address: params.address,
        city: params.city, 
        email: params.email, 
        password: params.password
      )
    );
  }
}
