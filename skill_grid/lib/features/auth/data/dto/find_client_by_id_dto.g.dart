// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_client_by_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FindClientByIdDto _$FindClientByIdDtoFromJson(Map<String, dynamic> json) =>
    FindClientByIdDto(
      clientId: json['_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      mobileNo: json['mobile_no'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      city: json['city'] as String,
      profilePicture: json['profile_picture'] as String?,
      role: json['role'] as String,
    );

Map<String, dynamic> _$FindClientByIdDtoToJson(FindClientByIdDto instance) =>
    <String, dynamic>{
      '_id': instance.clientId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'mobile_no': instance.mobileNo,
      'email': instance.email,
      'password': instance.password,
      'city': instance.city,
      'profile_picture': instance.profilePicture,
      'role': instance.role,
    };
