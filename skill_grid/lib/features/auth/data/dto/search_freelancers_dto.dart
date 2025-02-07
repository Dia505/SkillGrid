import 'package:json_annotation/json_annotation.dart';
part 'search_freelancers_dto.g.dart';

@JsonSerializable()
class SearchFreelancersDto {
  @JsonKey(name: '_id')
  final String freelancerId;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'date_of_birth')
  final DateTime dateOfBirth;
  @JsonKey(name: 'mobile_no')
  final String mobileNo;
  final String address;
  final String city;
  final String email;
  final String password;
  @JsonKey(name: 'profile_picture')
  final String? profilePicture;
  @JsonKey(name: 'background_picture')
  final String? backgroundPicture;
  final bool available;
  final String? bio;
  @JsonKey(name: 'job_category')
  final String? jobCategory;
  final String? profession;
  final String? skills;
  @JsonKey(name: 'years_of_experience')
  final int? yearsOfExperience;
  final String role;

  SearchFreelancersDto({
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
    required this.available,
    this.bio,
    this.jobCategory,
    this.profession,
    this.skills,
    this.yearsOfExperience,
    required this.role,
  });

  factory SearchFreelancersDto.fromJson(Map<String, dynamic> json) =>
      _$SearchFreelancersDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SearchFreelancersDtoToJson(this);
}
