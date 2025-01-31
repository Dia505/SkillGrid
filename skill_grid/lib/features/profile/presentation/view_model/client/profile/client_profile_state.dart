part of 'client_profile_cubit.dart';

abstract class ClientProfileState extends Equatable {
  const ClientProfileState();

  @override
  List<Object?> get props => [];
}

class ClientProfileInitial extends ClientProfileState {}

class ClientProfileLoading extends ClientProfileState {}

class ClientProfileLoaded extends ClientProfileState {
  final ClientEntity clientEntity;
  const ClientProfileLoaded(this.clientEntity);

  @override
  List<Object?> get props => [clientEntity];
}

class ClientProfileError extends ClientProfileState {
  final String message;
  const ClientProfileError(this.message);

  @override
  List<Object?> get props => [message];
}