// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:skill_grid/app/use_case/use_case.dart';
// import 'package:skill_grid/core/error/failure.dart';
// import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
// import 'package:skill_grid/features/auth/domain/repository/freelancer_repository.dart';

// class UpdateFreelancerParams extends Equatable {
//   final String? firstName;
//   final String? lastName;
//   final DateTime? dateOfBirth;
//   final String? mobileNo;
//   final String? address;
//   final String? city;
//   final String? email;
//   final String? password;
//   final String? jobCategory;
//   final String? profession;
//   final String? skills;
//   final int? yearsOfExperience;
//   final String? bio;
//   final bool? available;

//   const UpdateFreelancerParams(
//       {this.firstName,
//       this.lastName,
//       this.dateOfBirth,
//       this.mobileNo,
//       this.address,
//       this.city,
//       this.email,
//       this.password,
//       this.jobCategory,
//       this.profession,
//       this.skills,
//       this.yearsOfExperience,
//       this.bio,
//       this.available});

//   @override
//   List<Object?> get props => [
//         firstName,
//         lastName,
//         dateOfBirth,
//         mobileNo,
//         address,
//         city,
//         email,
//         password,
//         jobCategory,
//         profession,
//         skills,
//         yearsOfExperience,
//         bio,
//         available,
//       ];
// }

// class UpdateFreelancerUseCase implements UsecaseWithParams<void, UpdateFreelancerParams> {
//   final IFreelancerRepository freelancerRepository;

//   UpdateFreelancerUseCase({required this.freelancerRepository});

//   @override
//   Future<Either<Failure, void>> call(UpdateFreelancerParams params) async {
//     return await freelancerRepository.updateFreelancer(
//       FreelancerEntity(
//         firstName: params.firstName, 
//         lastName: params.lastName, 
//         dateOfBirth: params.dateOfBirth,
//         mobileNo: params.mobileNo, 
//         address: params.address,
//         city: params.city, 
//         email: params.email, 
//         password: params.password,
//         jobCategory: params.jobCategory,
//         profession: params.profession,
//         skills: params.skills,
//         yearsOfExperience: params.yearsOfExperience,
//         bio: params.bio,
//         available: params.available
//       )
//     );
//   }
// }
