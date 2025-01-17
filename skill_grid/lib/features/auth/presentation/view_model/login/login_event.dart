part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class NavigateJoinAsClientFreelancerEvent extends LoginEvent {
  final BuildContext context;
  final Widget destination; 

  const NavigateJoinAsClientFreelancerEvent({
    required this.context,
    required this.destination,
  });
}

class NavigateHomeScreenEvent extends LoginEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateHomeScreenEvent({
    required this.context,
    required this.destination,
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

