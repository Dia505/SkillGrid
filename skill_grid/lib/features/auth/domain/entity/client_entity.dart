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

  const ClientEntity({
    this.clientId,
    required this.firstName,
    required this.lastName,
    required this.mobileNo,
    required this.city,
    required this.email,
    required this.password,
    this.profilePicture,
  });

  @override
  List<Object?> get props =>
      [clientId, firstName, lastName, mobileNo, city, email, password, profilePicture];
}

