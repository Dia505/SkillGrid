part of 'onboard_screen_cubit.dart';

@immutable
sealed class OnboardScreenEvent extends Equatable {
  const OnboardScreenEvent();

  @override
  List<Object?> get props => [];
}

class NavigateToLoginScreen extends OnboardScreenEvent {
  final BuildContext context;
  final Widget destination; 

  const NavigateToLoginScreen({
    required this.context,
    required this.destination,
  });
}

class NavigateJoinAsClientFreelancerEvent extends OnboardScreenEvent {
  final BuildContext context;
  final Widget destination; 

  const NavigateJoinAsClientFreelancerEvent({
    required this.context,
    required this.destination,
  });
}