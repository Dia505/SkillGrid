part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class NavigateToRegistrationEvent extends LoginEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToRegistrationEvent({
    required this.context,
    required this.destination,
  });
}

class NavigateHomeScreenEvent extends LoginEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateHomeScreenEvent({
    required this.context,
    required this.destination
  });
}

class LoginUserEvent extends LoginEvent {
  final BuildContext context;
  final String email;
  final String password;

  const LoginUserEvent({
    required this.context,
    required this.email,
    required this.password,
  });
}

class NavigateToSendOtpScreen extends LoginEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToSendOtpScreen({
    required this.context,
    required this.destination,
  });
}
