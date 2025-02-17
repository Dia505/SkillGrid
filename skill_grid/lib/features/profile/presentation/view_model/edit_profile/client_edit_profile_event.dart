part of 'client_edit_profile_bloc.dart';

@immutable
sealed class ClientEditProfileEvent extends Equatable {
  const ClientEditProfileEvent();

  @override
  List<Object?> get props => [];
}

class NavigateToClientProfile extends ClientEditProfileEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToClientProfile(
      {required this.context, required this.destination});
}

class UpdateProfilePicture extends ClientEditProfileEvent {
  final String clientId;
  final File file;
  final String? token;
  final BuildContext context;

  const UpdateProfilePicture(
      {required this.clientId,
      required this.file,
      this.token,
      required this.context});

  @override
  List<Object?> get props => [clientId, file, context];
}

class UpdateClient extends ClientEditProfileEvent {
  final String clientId;
  final String? firstName;
  final String? lastName;
  final String? mobileNo;
  final String? city;
  final String? email;
  final String? password;
  final BuildContext context;

  const UpdateClient(
      {required this.clientId,
      this.firstName,
      this.lastName,
      this.mobileNo,
      this.city,
      this.email,
      this.password,
      required this.context});

  @override
  List<Object?> get props =>
      [clientId, firstName, lastName, mobileNo, city, email, password, context];
}
