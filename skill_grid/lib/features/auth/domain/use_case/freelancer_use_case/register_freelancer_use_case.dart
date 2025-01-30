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
  final String? jobCategory;
  final String? profession;
  final String? skills;
  final int? yearsOfExperience;
  final String? bio;
  final bool available;
  final String? profilePicture;
  final String? backgroundPicture;

  const CreateFreelancerParams({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.mobileNo,
    required this.address,
    required this.city,
    required this.email,
    required this.password,
    this.jobCategory,
    this.profession,
    this.skills,
    this.yearsOfExperience,
    this.bio,
    required this.available,
    this.profilePicture,
    this.backgroundPicture
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
        password,
        jobCategory,
        profession,
        skills,
        yearsOfExperience,
        bio,
        available,
        profilePicture,
        backgroundPicture,
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
        password: params.password,
        jobCategory: params.jobCategory,
        profession: params.profession,
        skills: params.skills,
        yearsOfExperience: params.yearsOfExperience,
        bio: params.bio,
        available: params.available,
        profilePicture: params.profilePicture,
        backgroundPicture: params.backgroundPicture
      ),
    );
  }
}

