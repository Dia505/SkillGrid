import 'package:equatable/equatable.dart';

class ClientEntity extends Equatable {
  final String? clientId;
  final String firstName;
  final String lastName;
  final String mobileNo;
  final String city;
  final String email;
  final String password;
  final String? profilePicture;
  final String role;
  final String? otp;
  final DateTime? otpExpiresAt;

  const ClientEntity({
    this.clientId,
    required this.firstName,
    required this.lastName,
    required this.mobileNo,
    required this.city,
    required this.email,
    required this.password,
    this.profilePicture,
    this.role = "client",
    this.otp,
    this.otpExpiresAt
  });

  ClientEntity copyWith({
    String? firstName,
    String? lastName,
    String? mobileNo,
    String? city,
    String? email,
    String? password,
    String? profilePicture,
    String? role,
  }) {
    return ClientEntity(
      clientId: clientId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      mobileNo: mobileNo ?? this.mobileNo,
      city: city ?? this.city,
      email: email ?? this.email,
      password: password ?? this.password,
      profilePicture: profilePicture ?? this.profilePicture,
      role: role ?? this.role,
    );
  }

  ClientEntity.empty()
    : clientId = "_empty.clientId",
      firstName = "_empty.firstName",
      lastName = "_empty.lastName",
      mobileNo = "_empty.mobileNo",
      city = "_empty.city",
      email = "_empty.email",
      password = "_empty.password",
      profilePicture = "_empty.profilePicture",
      role = "_empty.role",
      otp = "_empty.otp",
      otpExpiresAt = DateTime(1970);

  @override
  List<Object?> get props =>
      [clientId, firstName, lastName, mobileNo, city, email, password, profilePicture, role, otp, otpExpiresAt];
}

