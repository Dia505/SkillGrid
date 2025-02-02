part of 'client_profile_bloc.dart';

@immutable
sealed class ClientProfileEvent extends Equatable {
  const ClientProfileEvent();

  @override
  List<Object?> get props => [];
}

class NavigateToEditClientProfile extends ClientProfileEvent {
  final BuildContext context;

  const NavigateToEditClientProfile({
    required this.context
  });
}