part of 'send_otp_bloc.dart';

@immutable 
sealed class SendOtpEvent extends Equatable {
  const SendOtpEvent();

  @override
  List<Object> get props => [];
}

class SendEmailEvent extends SendOtpEvent {
  final BuildContext context;
  final String email;

  const SendEmailEvent({
    required this.context,
    required this.email,
  });
}

class NavigateToVerifyOtpScreen extends SendOtpEvent {
  final BuildContext context;
  final Widget destination; 

  const NavigateToVerifyOtpScreen({
    required this.context,
    required this.destination,
  });
}

class NavigateToLoginScreen extends SendOtpEvent {
  final BuildContext context;
  final Widget destination; 

  const NavigateToLoginScreen({
    required this.context,
    required this.destination,
  });
}