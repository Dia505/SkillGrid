part of 'client_edit_profile_bloc.dart';

@immutable 
sealed class ClientEditProfileEvent extends Equatable {
  const ClientEditProfileEvent();

  @override
  List<Object?> get props => [];
}

class NavigateToClientProfile extends ClientEditProfileEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToClientProfile({
    required this.context,
    required this.destination
  });
}

class UpdateProfilePicture extends ClientEditProfileEvent {
  final String clientId;
  final File file;

  const UpdateProfilePicture({
    required this.clientId,
    required this.file,
  });

  @override
  List<Object?> get props => [clientId, file];
}