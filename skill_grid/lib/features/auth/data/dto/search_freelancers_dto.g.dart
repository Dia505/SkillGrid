// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_freelancers_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchFreelancersDto _$SearchFreelancersDtoFromJson(
        Map<String, dynamic> json) =>
    SearchFreelancersDto(
      freelancerId: json['_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      dateOfBirth: DateTime.parse(json['date_of_birth'] as String),
      mobileNo: json['mobile_no'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      profilePicture: json['profile_picture'] as String?,
      backgroundPicture: json['background_picture'] as String?,
      available: json['available'] as bool,
      bio: json['bio'] as String?,
      jobCategory: json['job_category'] as String?,
      profession: json['profession'] as String?,
      skills: json['skills'] as String?,
      yearsOfExperience: (json['years_of_experience'] as num?)?.toInt(),
      role: json['role'] as String,
    );

Map<String, dynamic> _$SearchFreelancersDtoToJson(
        SearchFreelancersDto instance) =>
    <String, dynamic>{
      '_id': instance.freelancerId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'date_of_birth': instance.dateOfBirth.toIso8601String(),
      'mobile_no': instance.mobileNo,
      'address': instance.address,
      'city': instance.city,
      'email': instance.email,
      'password': instance.password,
      'profile_picture': instance.profilePicture,
      'background_picture': instance.backgroundPicture,
      'available': instance.available,
      'bio': instance.bio,
      'job_category': instance.jobCategory,
      'profession': instance.profession,
      'skills': instance.skills,
      'years_of_experience': instance.yearsOfExperience,
      'role': instance.role,
    };
