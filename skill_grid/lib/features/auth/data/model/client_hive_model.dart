import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:skill_grid/app/constants/hive_table_constant.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:uuid/uuid.dart';

part 'client_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.clientTableId)
class ClientHiveModel extends Equatable {
  @HiveField(0)
  final String clientId;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String mobileNo;
  @HiveField(4)
  final String city;
  @HiveField(5)
  final String email;
  @HiveField(6)
  final String password;
  @HiveField(7)
  final String profilePicture;

  ClientHiveModel(
      {String? clientId,
      required this.firstName,
      required this.lastName,
      required this.mobileNo,
      required this.city,
      required this.email,
      required this.password,
      String? profilePicture})
      : clientId = clientId ?? const Uuid().v4(),
        profilePicture =
            profilePicture ?? "assets/images/default_profile_img.png";

  const ClientHiveModel.initial()
      : clientId = "",
        firstName = "",
        lastName = "",
        mobileNo = "",
        city = "",
        email = "",
        password = "",
        profilePicture = "assets/images/default_profile_img.png";

  factory ClientHiveModel.fromEntity(ClientEntity entity) {
    return ClientHiveModel(
        clientId: entity.clientId,
        firstName: entity.firstName,
        lastName: entity.lastName,
        mobileNo: entity.mobileNo,
        city: entity.city,
        email: entity.email,
        password: entity.password,
        profilePicture: entity.profilePicture);
  }

  ClientEntity toEntity() {
    return ClientEntity(
        clientId: clientId,
        firstName: firstName,
        lastName: lastName,
        mobileNo: mobileNo,
        city: city,
        email: email,
        password: password,
        profilePicture: profilePicture);
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
        profilePicture
      ];
}
