import 'package:json_annotation/json_annotation.dart';
part 'find_client_by_id_dto.g.dart';

@JsonSerializable()

class FindClientByIdDto {
  @JsonKey(name: "_id")
  final String clientId;
  @JsonKey(name: "first_name")
  final String firstName;
  @JsonKey(name: "last_name")
  final String lastName;
  @JsonKey(name: "mobile_no")
  final String mobileNo;
  final String email;
  final String password; 
  final String city;
  @JsonKey(name: "profile_picture")
  final String? profilePicture;
  final String role;

  FindClientByIdDto({
    required this.clientId,
    required this.firstName,
    required this.lastName,
    required this.mobileNo,
    required this.email,
    required this.password,
    required this.city,
    this.profilePicture,
    required this.role,
  });

  Map<String, dynamic> toJson() => _$FindClientByIdDtoToJson(this);

  factory FindClientByIdDto.fromJson(Map<String, dynamic> json) =>
    _$FindClientByIdDtoFromJson(json);
}