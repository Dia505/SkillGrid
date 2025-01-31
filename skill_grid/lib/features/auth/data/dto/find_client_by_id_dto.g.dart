// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_client_by_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FindClientByIdDto _$FindClientByIdDtoFromJson(Map<String, dynamic> json) =>
    FindClientByIdDto(
      clientId: json['clientId'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      mobileNo: json['mobileNo'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      city: json['city'] as String,
      profilePicture: json['profilePicture'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$FindClientByIdDtoToJson(FindClientByIdDto instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'mobileNo': instance.mobileNo,
      'email': instance.email,
      'password': instance.password,
      'city': instance.city,
      'profilePicture': instance.profilePicture,
      'role': instance.role,
    };
