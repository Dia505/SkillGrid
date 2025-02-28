part of "client_home_bloc.dart";

abstract class ClientHomeState extends Equatable {
  const ClientHomeState();

  @override
  List<Object?> get props => [];
}

class ClientHomeInitial extends ClientHomeState {}

class ClientHomeLoading extends ClientHomeState {}

class ClientHomeLoaded extends ClientHomeState {
  final ClientEntity clientEntity;
  const ClientHomeLoaded(this.clientEntity);

  @override
  List<Object?> get props => [clientEntity];
}

class ClientHomeError extends ClientHomeState {
  final String message;
  const ClientHomeError(this.message);

  @override
  List<Object?> get props => [message];
}

class HomeContractsLoadingState extends ClientHomeState {}

class HomeContractsLoadedState extends ClientHomeState {
  final List<AppointmentEntity> appointments;

  const HomeContractsLoadedState(this.appointments);

  @override
  List<Object?> get props => [appointments];
}
