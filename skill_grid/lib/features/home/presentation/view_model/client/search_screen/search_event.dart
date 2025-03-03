part of 'search_bloc.dart';

@immutable
sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchFreelancers extends SearchEvent {
  final String searchQuery;
  const SearchFreelancers(this.searchQuery);
}

class FilterByCriteria extends SearchEvent {
  final String? city;
  final List<String> hourlyRates;
  final int? rating;
  const FilterByCriteria(this.city, this.hourlyRates, this.rating);
}

class NavigateToFreelancerProfile extends SearchEvent {
  final String freelancerId;
  final BuildContext context;
  final Widget destination;

  const NavigateToFreelancerProfile({required this.freelancerId, required this.context, required this.destination});

  @override
  List<Object> get props => [freelancerId];
}

class ClearSearch extends SearchEvent {} 
