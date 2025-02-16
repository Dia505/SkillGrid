import 'package:json_annotation/json_annotation.dart';
part 'login_dto.g.dart';

@JsonSerializable()
class LoginDto {
  final String token;
  final String role;
  final String userId;

  LoginDto({
    required this.token,
    required this.role,
    required this.userId
  });

  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);

  factory LoginDto.fromJson(Map<String, dynamic> json) =>
    _$LoginDtoFromJson(json);
}