import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';

part 'client_api_model.g.dart';

@JsonSerializable()
class ClientApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String? clientId;
  @JsonKey(name: "first_name")
  final String firstName;
  @JsonKey(name: "last_name")
  final String lastName;
  @JsonKey(name: "mobile_no")
  final String mobileNo;
  final String city;
  final String email;
  final String password;
  @JsonKey(name: "profile_picture")
  final String? profilePicture;
  final String role;

  const ClientApiModel(
      {this.clientId,
      required this.firstName,
      required this.lastName,
      required this.mobileNo,
      required this.city,
      required this.email,
      required this.password,
      String? profilePicture,
      this.role = "client"})
      : profilePicture =
            profilePicture ?? "assets/images/default_profile_img.png";

  factory ClientApiModel.fromJson(Map<String, dynamic> json) {
    return _$ClientApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ClientApiModelToJson(this);

  factory ClientApiModel.fromEntity(ClientEntity entity) {
    return ClientApiModel(
        firstName: entity.firstName,
        lastName: entity.lastName,
        mobileNo: entity.mobileNo,
        city: entity.city,
        email: entity.email,
        password: entity.password,
        profilePicture: entity.profilePicture,
        role: entity.role);
  }

  ClientEntity toEntity() {
    return ClientEntity(
        firstName: firstName,
        lastName: lastName,
        mobileNo: mobileNo,
        city: city,
        email: email,
        password: password,
        profilePicture: profilePicture,
        role: role);
  }

  @override
  List<Object?> get props => [
        clientId,
        firstName,
        lastName,
        mobileNo,
        city,
        email,
        password,
        profilePicture,
        role
      ];
}
