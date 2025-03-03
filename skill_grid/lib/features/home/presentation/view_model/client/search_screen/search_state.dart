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
  final Map<String, int> avgRatingMap;
  final String? selectedCity;
  final String? selectedHourlyRate;
  final int? selectedRating;

  const SearchLoaded(
    this.freelancers, 
    this.portfolioMap, 
    this.avgHourlyRateMap,
    this.avgRatingMap,
    {this.selectedCity, this.selectedHourlyRate, this.selectedRating});

  @override
  List<Object?> get props =>
      [freelancers, portfolioMap, avgHourlyRateMap, avgRatingMap, selectedCity, selectedHourlyRate, selectedRating];

  SearchLoaded copyWith({String? selectedCity, String? selectedHourlyRate, int? selectedRating}) {
    return SearchLoaded(
      freelancers,
      portfolioMap,
      avgHourlyRateMap,
      avgRatingMap,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedHourlyRate: selectedHourlyRate ?? this.selectedHourlyRate,
      selectedRating: selectedRating ?? this.selectedRating
    );
  }
}

class SearchError extends SearchState {
  final String message;
  const SearchError(this.message);
}




