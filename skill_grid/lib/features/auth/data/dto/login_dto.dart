import 'package:json_annotation/json_annotation.dart';
part 'login_dto.g.dart';

@JsonSerializable()
class LoginDto {
  final bool success;
  final String token;

  LoginDto({
    required this.success,
    required this.token
  });

  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);

  factory LoginDto.fromJson(Map<String, dynamic> json) =>
    _$LoginDtoFromJson(json);
}