part of 'client_home_bloc.dart';

@immutable
sealed class ClientHomeEvent extends Equatable {
  const ClientHomeEvent();

  @override
  List<Object?> get props => [];
}

class SearchFreelancers extends ClientHomeEvent {
  final String searchQuery;
  final BuildContext context;
  const SearchFreelancers(this.searchQuery, this.context);
}

class NavigateToSearchScreenEvent extends ClientHomeEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToSearchScreenEvent({
    required this.context,
    required this.destination,
  });
}

class FetchClientContracts extends ClientHomeEvent {
  final String clientId;

  const FetchClientContracts({required this.clientId});

  @override
  List<Object> get props => [clientId];
}
