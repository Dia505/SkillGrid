part of 'client_profile_bloc.dart';

@immutable
sealed class ClientProfileEvent extends Equatable {
  const ClientProfileEvent();

  @override
  List<Object?> get props => [];
}

class NavigateToEditClientProfile extends ClientProfileEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToEditClientProfile({
    required this.context,
    required this.destination
  });
}

class NavigateToClientDashboard extends ClientProfileEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToClientDashboard({
    required this.context,
    required this.destination
  });
}