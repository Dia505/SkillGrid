part of 'client_sidebar_bloc.dart';

@immutable 
sealed class ClientSidebarEvent extends Equatable {
  const ClientSidebarEvent();

  @override
  List<Object?> get props => [];
}

class ToggleSidebar extends ClientSidebarEvent {}

class NavigateToClientProfile extends ClientSidebarEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToClientProfile({
    required this.context,
    required this.destination
  });
}