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

class ClientHomeSearchLoading extends ClientHomeState {}

class ClientHomeSearchLoaded extends ClientHomeState {
  final List<FreelancerEntity> freelancers;
  const ClientHomeSearchLoaded(this.freelancers);

  @override
  List<Object?> get props => [freelancers];
}

class ClientHomeSearchError extends ClientHomeState {
  final String message;
  const ClientHomeSearchError(this.message);

  @override
  List<Object?> get props => [message];
}

