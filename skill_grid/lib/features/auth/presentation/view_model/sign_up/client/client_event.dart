part of 'client_bloc.dart';

@immutable 
sealed class ClientEvent extends Equatable {
  const ClientEvent();

  @override
  List<Object> get props => [];
}

class RegisterClient extends ClientEvent {
  final BuildContext context;
  final String firstName;
  final String lastName;
  final String mobileNo;
  final String city;
  final String email;
  final String password;

  const RegisterClient({
    required this.context,
    required this.firstName,
    required this.lastName,
    required this.mobileNo,
    required this.city,
    required this.email,
    required this.password,
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