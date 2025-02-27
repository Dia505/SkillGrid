import 'package:equatable/equatable.dart';

class FreelancerEntity extends Equatable {
  final String? freelancerId;
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
  final String role;

  const FreelancerEntity(
      {this.freelancerId,
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
      this.available = true,
      this.profilePicture,
      this.backgroundPicture,
      this.role = "freelancer"});

  FreelancerEntity.empty()
    : freelancerId = "_empty.freelancerId",
      firstName = "_empty.firstName",
      lastName = "_empty.lastName",
      dateOfBirth = DateTime(1970),
      mobileNo = "_empty.mobileNo",
      address = "_empty.address",
      city = "_empty.city",
      email = "_empty.email",
      password = "_empty.password",
      jobCategory = "_empty.jobCategory",
      profession = "_empty.profession",
      skills = "_empty.skills",
      yearsOfExperience = 0,
      bio = "_empty.bio",
      available = true,
      profilePicture = "_empty.profilePicture",
      backgroundPicture = "_empty.backgroundPicture",
      role = "_empty.role";

  @override
  List<Object?> get props => [
        freelancerId,
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
        role
      ];
}
