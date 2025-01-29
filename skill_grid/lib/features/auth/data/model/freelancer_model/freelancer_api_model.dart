import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';

part 'freelancer_api_model.g.dart';

@JsonSerializable()
class FreelancerApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String? freelancerId;
  @JsonKey(name: "first_name")
  final String firstName;
  @JsonKey(name: "last_name")
  final String lastName;
  @JsonKey(name: "date_of_birth")
  final DateTime dateOfBirth;
  @JsonKey(name: "mobile_no")
  final String mobileNo;
  final String address;
  final String city;
  final String email;
  final String password;
  @JsonKey(name: "job_category")
  final String? jobCategory;
  final String? profession;
  final String? skills;
  @JsonKey(name: "years_of_experience")
  final int? yearsOfExperience;
  final String? bio;
  final bool? available;
  @JsonKey(name: "profile_picture")
  final String? profilePicture;
  @JsonKey(name: "background_picture")
  final String? backgroundPicture;
  final String role;

  const FreelancerApiModel(
      {this.freelancerId,
      required this.firstName,
      required this.lastName,
      required this.dateOfBirth,
      required this.mobileNo,
      required this.address,
      required this.city,
      required this.email,
      required this.password,
      String? jobCategory,
      String? profession,
      String? skills,
      int? yearsOfExperience,
      String? bio,
      bool? available,
      String? profilePicture,
      String? backgroundPicture,
      this.role = "freelancer"})
      : jobCategory = jobCategory ?? "",
        profession = profession ?? "",
        skills = skills ?? "",
        yearsOfExperience = yearsOfExperience ?? 0,
        bio = bio ?? "",
        available = available ?? true,
        profilePicture =
            profilePicture ?? "assets/images/default_profile_img.png",
        backgroundPicture =
            backgroundPicture ?? "assets/images/default_bg_img.jpg";

  factory FreelancerApiModel.fromJson(Map<String, dynamic> json) {
    return _$FreelancerApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FreelancerApiModelToJson(this);

  factory FreelancerApiModel.fromEntity(FreelancerEntity entity) {
    return FreelancerApiModel(
        firstName: entity.firstName,
        lastName: entity.lastName,
        dateOfBirth: entity.dateOfBirth,
        mobileNo: entity.mobileNo,
        address: entity.address,
        city: entity.city,
        email: entity.email,
        password: entity.password,
        jobCategory: entity.jobCategory,
        profession: entity.profession,
        skills: entity.skills,
        yearsOfExperience: entity.yearsOfExperience,
        bio: entity.bio,
        available: entity.available,
        profilePicture: entity.profilePicture,
        backgroundPicture: entity.backgroundPicture,
        role: entity.role);
  }

  FreelancerEntity toEntity() {
    return FreelancerEntity(
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
        mobileNo: mobileNo,
        address: address,
        city: city,
        email: email,
        password: password,
        jobCategory: jobCategory,
        profession: profession,
        skills: skills,
        yearsOfExperience: yearsOfExperience,
        bio: bio,
        available: available,
        profilePicture: profilePicture,
        backgroundPicture: backgroundPicture,
        role: role);
  }

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
