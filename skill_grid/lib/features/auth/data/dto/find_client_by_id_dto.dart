import 'package:json_annotation/json_annotation.dart';
part 'find_client_by_id_dto.g.dart';

@JsonSerializable()

class FindClientByIdDto {
  final String clientId;
  final String firstName;
  final String lastName;
  final String mobileNo;
  final String email;
  final String password; 
  final String city;
  final String profilePicture;
  final String role;

  FindClientByIdDto({
    required this.clientId,
    required this.firstName,
    required this.lastName,
    required this.mobileNo,
    required this.email,
    required this.password,
    required this.city,
    required this.profilePicture,
    required this.role,
  });

  Map<String, dynamic> toJson() => _$FindClientByIdDtoToJson(this);

  factory FindClientByIdDto.fromJson(Map<String, dynamic> json) =>
    _$FindClientByIdDtoFromJson(json);
}