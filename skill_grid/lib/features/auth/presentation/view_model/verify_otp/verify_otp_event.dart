part of 'verify_otp_bloc.dart';

@immutable 
sealed class VerifyOtpEvent extends Equatable {
  const VerifyOtpEvent();

  @override
  List<Object> get props => [];
}

class CheckOtpEvent extends VerifyOtpEvent {
  final BuildContext context;
  final String email;
  final String otp;

  const CheckOtpEvent({
    required this.context,
    required this.email,
    required this.otp
  });
}

class NavigateToResetPasswodScreen extends VerifyOtpEvent {
  final BuildContext context;
  final Widget destination; 

  const NavigateToResetPasswodScreen({
    required this.context,
    required this.destination,
  });
}

class NavigateToLoginScreen extends VerifyOtpEvent {
  final BuildContext context;
  final Widget destination; 

  const NavigateToLoginScreen({
    required this.context,
    required this.destination,
  });
}