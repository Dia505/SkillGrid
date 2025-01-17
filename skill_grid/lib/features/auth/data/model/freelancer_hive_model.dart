import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:skill_grid/app/constants/hive_table_constant.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:uuid/uuid.dart';

part 'freelancer_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.freelancerTableId)
class FreelancerHiveModel extends Equatable {
  @HiveField(0)
  final String freelancerId;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final DateTime dateOfBirth;
  @HiveField(4)
  final String mobileNo;
  @HiveField(5)
  final String address;
  @HiveField(6)
  final String city;
  @HiveField(7)
  final String email;
  @HiveField(8)
  final String password;
  @HiveField(9)
  final String profilePicture;
  @HiveField(10)
  final String? backgroundPicture;
  @HiveField(11)
  final String role;

  FreelancerHiveModel(
      {String? freelancerId,
      required this.firstName,
      required this.lastName,
      required this.dateOfBirth,
      required this.mobileNo,
      required this.address,
      required this.city,
      required this.email,
      required this.password,
      String? profilePicture,
      String? backgroundPicture,
      this.role = "freelancer"})
      : freelancerId = freelancerId ?? const Uuid().v4(),
        profilePicture =
            profilePicture ?? "assets/images/default_profile_img.png",
        backgroundPicture =
            backgroundPicture ?? "assets/images/default_bg_img.jpg";

    FreelancerHiveModel.initial()
      : freelancerId = "",
        firstName = "",
        lastName = "",
        dateOfBirth = DateTime(1970, 1, 1),
        mobileNo = "",
        address = "",
        city = "",
        email = "",
        password = "",
        profilePicture = "assets/images/default_profile_img.png",
        backgroundPicture = "assets/images/default_bg_img.jpg",
        role = "freelancer";

    factory FreelancerHiveModel.fromEntity(FreelancerEntity entity) {
      return FreelancerHiveModel(
        freelancerId: entity.freelancerId,
        firstName: entity.firstName, 
        lastName: entity.lastName, 
        dateOfBirth: entity.dateOfBirth, 
        mobileNo: entity.mobileNo, 
        address: entity.address, 
        city: entity.city, 
        email: entity.email, 
        password: entity.password,
        profilePicture: entity.profilePicture,
        backgroundPicture: entity.backgroundPicture,
        role: entity.role
      );
    }

    FreelancerEntity toEntity() {
      return FreelancerEntity(
        freelancerId: freelancerId,
        firstName: firstName, 
        lastName: lastName, 
        dateOfBirth: dateOfBirth, 
        mobileNo: mobileNo, 
        address: address, 
        city: city, 
        email: email, 
        password: password,
        profilePicture: profilePicture,
        backgroundPicture: backgroundPicture,
        role: role
      );
    }

  @override
  List<Object?> get props => [
        freelancerId,
        firstName,
        lastName,
        dateOfBirth,
        mobileNo,
        address,
        city,
        email,
        password,
        profilePicture,
        backgroundPicture,
        role
      ];
}
