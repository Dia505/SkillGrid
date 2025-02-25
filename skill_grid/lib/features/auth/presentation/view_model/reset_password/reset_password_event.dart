part of 'reset_password_bloc.dart';

@immutable 
sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordEvent extends ResetPasswordEvent {
  final BuildContext context;
  final String email;
  final String otp;
  final String newPassword;

  const ChangePasswordEvent({
    required this.context,
    required this.email,
    required this.otp,
    required this.newPassword
  });
}

class NavigateToLoginScreen extends ResetPasswordEvent {
  final BuildContext context;
  final Widget destination; 

  const NavigateToLoginScreen({
    required this.context,
    required this.destination,
  });
}