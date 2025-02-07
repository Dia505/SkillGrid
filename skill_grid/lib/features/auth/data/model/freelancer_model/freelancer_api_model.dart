import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:skill_grid/features/auth/data/dto/find_freelancer_by_id_dto.dart';
import 'package:skill_grid/features/auth/data/dto/search_freelancers_dto.dart';
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
  final bool available;
  @JsonKey(name: "profile_picture")
  final String? profilePicture;
  @JsonKey(name: "background_picture")
  final String? backgroundPicture;
  final String role;

  const FreelancerApiModel({
    this.freelancerId,
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
    this.profilePicture = "assets/images/default_profile_img.png",
    this.backgroundPicture = "assets/images/default_bg_img.jpg",
    this.role = "freelancer",
  });

  factory FreelancerApiModel.fromJson(Map<String, dynamic> json) =>
      _$FreelancerApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$FreelancerApiModelToJson(this);

  static FreelancerEntity findFreelancerByIdDtoToEntity(
      FindFreelancerByIdDto findFreelancerByIdDto) {
    return FreelancerEntity(
      freelancerId: findFreelancerByIdDto.freelancerId,
      firstName: findFreelancerByIdDto.firstName,
      lastName: findFreelancerByIdDto.lastName,
      dateOfBirth: findFreelancerByIdDto.dateOfBirth,
      mobileNo: findFreelancerByIdDto.mobileNo,
      address: findFreelancerByIdDto.address,
      city: findFreelancerByIdDto.city,
      email: findFreelancerByIdDto.email,
      password: findFreelancerByIdDto.password,
      jobCategory: findFreelancerByIdDto.jobCategory,
      profession: findFreelancerByIdDto.profession,
      skills: findFreelancerByIdDto.skills,
      yearsOfExperience: findFreelancerByIdDto.yearsOfExperience,
      bio: findFreelancerByIdDto.bio,
      available: findFreelancerByIdDto.available,
      profilePicture: findFreelancerByIdDto.profilePicture,
      backgroundPicture: findFreelancerByIdDto.backgroundPicture,
      role: findFreelancerByIdDto.role,
    );
  }

  // Convert from FreelancerApiModel to Entity
  FreelancerEntity toEntity() {
    return FreelancerEntity(
      freelancerId: freelancerId,
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
      role: role,
    );
  }

  static FreelancerApiModel fromDto(SearchFreelancersDto dto) {
    return FreelancerApiModel(
      freelancerId: dto.freelancerId,
      firstName: dto.firstName,
      lastName: dto.lastName,
      dateOfBirth: dto.dateOfBirth,
      mobileNo: dto.mobileNo,
      address: dto.address,
      city: dto.city,
      email: dto.email,
      password: dto.password,
      jobCategory: dto.jobCategory,
      profession: dto.profession,
      skills: dto.skills,
      yearsOfExperience: dto.yearsOfExperience,
      bio: dto.bio,
      available: dto.available,
      profilePicture: dto.profilePicture,
      backgroundPicture: dto.backgroundPicture,
      role: dto.role,
    );
  }

  // Convert List of FreelancerApiModel to List of FreelancerEntity
  static List<FreelancerEntity> toEntityList(List<FreelancerApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

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
