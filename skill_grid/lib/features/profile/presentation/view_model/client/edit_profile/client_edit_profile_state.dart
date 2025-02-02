part of 'client_edit_profile_bloc.dart';

abstract class ClientEditProfileState extends Equatable {
  const ClientEditProfileState();

  @override
  List<Object?> get props => [];
}

class ClientEditProfileInitial extends ClientEditProfileState {}

class ClientEditProfileLoading extends ClientEditProfileState {}

class ClientEditProfileLoaded extends ClientEditProfileState {
  final ClientEntity clientEntity;
  const ClientEditProfileLoaded(this.clientEntity);

  @override
  List<Object?> get props => [clientEntity];
}

class ClientEditProfileError extends ClientEditProfileState {
  final String message;
  const ClientEditProfileError(this.message);

  @override
  List<Object?> get props => [message];
}