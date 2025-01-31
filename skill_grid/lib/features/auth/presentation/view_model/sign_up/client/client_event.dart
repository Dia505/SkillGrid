part of 'client_bloc.dart';

@immutable 
sealed class ClientEvent extends Equatable {
  const ClientEvent();

  @override
  List<Object> get props => [];
}

class LoadImage extends ClientEvent {
  final File file;

  const LoadImage({
    required this.file
  });
}

class RegisterClient extends ClientEvent {
  final BuildContext context;
  final String firstName;
  final String lastName;
  final String mobileNo;
  final String city;
  final String email;
  final String password;
  final String? profilePicture;

  const RegisterClient({
    required this.context,
    required this.firstName,
    required this.lastName,
    required this.mobileNo,
    required this.city,
    required this.email,
    required this.password,
    this.profilePicture
  });
}

class NavigateToLoginScreen extends ClientEvent {
  final BuildContext context;
  final Widget destination; 

  const NavigateToLoginScreen({
    required this.context,
    required this.destination,
  });
}