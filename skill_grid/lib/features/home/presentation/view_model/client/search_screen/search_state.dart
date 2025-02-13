part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<FreelancerEntity> freelancers;
  final Map<String, List<String>> portfolioMap;
  final Map<String, int> avgHourlyRateMap;
  final String? selectedCity;

  const SearchLoaded(
    this.freelancers, 
    this.portfolioMap, 
    this.avgHourlyRateMap,
    {this.selectedCity}
  );

  SearchLoaded copyWith({String? selectedCity}) {
    return SearchLoaded(
      freelancers,
      portfolioMap,
      avgHourlyRateMap,
      selectedCity: selectedCity ?? this.selectedCity,
    );
  }
}

class SearchError extends SearchState {
  final String message;
  const SearchError(this.message);
}
