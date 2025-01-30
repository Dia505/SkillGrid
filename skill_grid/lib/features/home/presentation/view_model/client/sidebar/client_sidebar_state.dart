part of 'client_sidebar_bloc.dart';

abstract class ClientSidebarState extends Equatable {
  const ClientSidebarState();

  @override
  List<Object> get props => [];
}

class SidebarClosed extends ClientSidebarState {}

class SidebarOpened extends ClientSidebarState {}

class NavigatingToClientProfile extends ClientSidebarState {}