import 'package:json_annotation/json_annotation.dart';
part 'find_freelancer_by_id_dto.g.dart';

@JsonSerializable()

class FindFreelancerByIdDto {
  @JsonKey(name: "_id")
  final String freelancerId;
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
  @JsonKey(name: "profile_picture")
  final String? profilePicture;
  @JsonKey(name: "background_picture")
  final String? backgroundPicture;
  final String role;
  @JsonKey(name: "job_category")
  final String? jobCategory;
  final String? profession;
  final String? skills;
  @JsonKey(name: "years_of_experience")
  final int? yearsOfExperience;
  final String? bio;
  final bool available;

  FindFreelancerByIdDto({
    required this.freelancerId,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.mobileNo,
    required this.address,
    required this.city,
    required this.email,
    required this.password,
    this.profilePicture,
    this.backgroundPicture,
    required this.role,
    this.jobCategory,
    this.profession,
    this.skills,
    this.yearsOfExperience,
    this.bio,
    required this.available
  });

  Map<String, dynamic> toJson() => _$FindFreelancerByIdDtoToJson(this);

  factory FindFreelancerByIdDto.fromJson(Map<String, dynamic> json) =>
    _$FindFreelancerByIdDtoFromJson(json);
}
