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

class FilterByCity extends SearchEvent {
  final String city;
  const FilterByCity(this.city);
}
