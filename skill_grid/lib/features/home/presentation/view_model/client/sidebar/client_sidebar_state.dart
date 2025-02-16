part of 'client_sidebar_bloc.dart';

abstract class ClientSidebarState extends Equatable {
  const ClientSidebarState();

  @override
  List<Object> get props => [];
}

class SidebarClosed extends ClientSidebarState {}

class SidebarOpened extends ClientSidebarState {}

class NavigatingToClientProfile extends ClientSidebarState {}

class ClientSidebarInitial extends ClientSidebarState {}

class ClientSidebarLoading extends ClientSidebarState {}

class ClientSidebarLoaded extends ClientSidebarState {
  final ClientEntity clientEntity;
  final bool isSidebarClosed;
  const ClientSidebarLoaded(this.clientEntity, this.isSidebarClosed);

  @override
  List<Object> get props => [clientEntity, isSidebarClosed];
}

class ClientSidebarError extends ClientSidebarState {
  final String message;
  const ClientSidebarError(this.message);

  @override
  List<Object> get props => [message];
}