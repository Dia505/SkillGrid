// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientApiModel _$ClientApiModelFromJson(Map<String, dynamic> json) =>
    ClientApiModel(
      clientId: json['_id'] as String?,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      mobileNo: json['mobile_no'] as String,
      city: json['city'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      profilePicture: json['profile_picture'] as String?,
      role: json['role'] as String? ?? "client",
      otp: json['otp'] as String?,
      otpExpiresAt: json['otpExpiresAt'] == null
          ? null
          : DateTime.parse(json['otpExpiresAt'] as String),
    );

Map<String, dynamic> _$ClientApiModelToJson(ClientApiModel instance) =>
    <String, dynamic>{
      '_id': instance.clientId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'mobile_no': instance.mobileNo,
      'city': instance.city,
      'email': instance.email,
      'password': instance.password,
      'profile_picture': instance.profilePicture,
      'role': instance.role,
      'otp': instance.otp,
      'otpExpiresAt': instance.otpExpiresAt?.toIso8601String(),
    };
