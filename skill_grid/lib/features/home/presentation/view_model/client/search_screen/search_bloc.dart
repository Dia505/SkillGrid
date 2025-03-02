import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/search_freelancers_use_case.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';
import 'package:skill_grid/features/freelancer_service/domain/use_case/get_freelancer_service_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/portfolio/domain/use_case/get_portfolio_by_freelancer_service_id_use_case.dart';
import 'package:skill_grid/features/profile/presentation/view_model/profile/freelancer/freelancer_profile_bloc.dart';
import 'package:skill_grid/features/review/domain/entity/review_entity.dart';
import 'package:skill_grid/features/review/domain/use_case/get_review_by_freelancer_id_use_case.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchFreelancersUseCase _searchFreelancersUseCase;
  final GetPortfolioByFreelancerServiceIdUseCase
      _getPortfolioByFreelancerServiceIdUseCase;
  final GetFreelancerServiceByFreelancerIdUseCase
      _getFreelancerSerivceByFreelancerIdUseCase;
  final GetReviewByFreelancerIdUseCase _getReviewByFreelancerIdUseCase;
  final FreelancerProfileBloc _freelancerProfileBloc;

  SearchBloc(
      {required SearchFreelancersUseCase searchFreelancersUseCase,
      required GetPortfolioByFreelancerServiceIdUseCase
          getPortfolioByFreelancerServiceIdUseCase,
      required GetFreelancerServiceByFreelancerIdUseCase
          getFreelancerSerivceByFreelancerIdUseCase,
      required GetReviewByFreelancerIdUseCase getReviewByFreelancerIdUseCase,
      required FreelancerProfileBloc freelancerProfileBloc})
      : _searchFreelancersUseCase = searchFreelancersUseCase,
        _getPortfolioByFreelancerServiceIdUseCase =
            getPortfolioByFreelancerServiceIdUseCase,
        _getFreelancerSerivceByFreelancerIdUseCase =
            getFreelancerSerivceByFreelancerIdUseCase,
        _getReviewByFreelancerIdUseCase = getReviewByFreelancerIdUseCase,
        _freelancerProfileBloc = freelancerProfileBloc,
        super(SearchInitial()) {
    on<SearchFreelancers>(_onSearchFreelancers);

    on<FilterByCriteria>(_onFilterByCriteria);

    on<NavigateToFreelancerProfile>((event, emit) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
              value: _freelancerProfileBloc, child: event.destination),
        ),
      );
    });
  }

  Future<void> _onSearchFreelancers(
      SearchFreelancers event, Emitter<SearchState> emit) async {
    emit(SearchLoading());

    final result = await _searchFreelancersUseCase(
      SearchFreelancersParams(searchQuery: event.searchQuery),
    );

    await result.fold(
      (failure) async {
        emit(SearchError(failure.message));
      },
      (freelancers) async {
        final Map<String, List<String>> portfolioMap = {};
        final Map<String, int> avgHourlyRateMap = {};
        final Map<String, int> avgRatingMap = {};

        // Process all freelancers concurrently
        await Future.wait(freelancers.map((freelancer) async {
          final freelancerId = freelancer.freelancerId!;

          // Fetch freelancer services concurrently
          final freelancerServicesResult =
              await _getFreelancerSerivceByFreelancerIdUseCase(
                  GetFreelancerServiceByFreelancerIdParams(
                      freelancerId: freelancerId));

          await freelancerServicesResult.fold(
            (failure) async => null, // Log error if necessary
            (services) async {
              avgHourlyRateMap[freelancerId] =
                  _calculateAverageHourlyRate(services);

              // Fetch portfolios concurrently
              final List<Future<List<String>>> portfolioFutures =
                  services.map((service) async {
                final portfolioResult =
                    await _getPortfolioByFreelancerServiceIdUseCase(
                        GetPortfolioByFreelancerServiceIdParams(
                            freelancerServiceId: service.freelancerServiceId!));

                return portfolioResult.fold(
                  (failure) => <String>[], // Return empty list on failure
                  (portfolio) => portfolio.filePath
                      .map((e) => e)
                      .toList(), // Ensure List<String>
                );
              }).toList();

              final portfolios = await Future.wait(portfolioFutures);
              portfolioMap[freelancerId] =
                  portfolios.expand((list) => list).toList();
            },
          );

          // Fetch reviews concurrently
          final reviewsResult = await _getReviewByFreelancerIdUseCase(
              GetReviewByFreelancerIdParams(freelancerId: freelancerId));

          await reviewsResult.fold(
            (failure) async => null,
            (reviews) async {
              avgRatingMap[freelancerId] = _calculateAverageRating(reviews);
            },
          );
        }));

        emit(SearchLoaded(
            freelancers, portfolioMap, avgHourlyRateMap, avgRatingMap));
      },
    );
  }

  int _calculateAverageHourlyRate(List<FreelancerServiceEntity> services) {
    if (services.isEmpty) return 0;

    final totalHourlyRate = services.fold<int>(
      0,
      (previousValue, service) => previousValue + service.hourlyRate,
    );

    return (totalHourlyRate / services.length).round();
  }

  int _calculateAverageRating(List<ReviewEntity> reviews) {
    if (reviews.isEmpty) return 0;

    final total = reviews.fold(0, (sum, review) => sum + (review.rating ?? 0));
    final avg = total ~/ reviews.length;
    return avg;
  }

  Future<void> _onFilterByCriteria(
      FilterByCriteria event, Emitter<SearchState> emit) async {
    if (state is SearchLoaded) {
      final currentState = state as SearchLoaded;

      var filteredFreelancers = currentState.freelancers;

      // Filter by city if selected
      if (event.city != null && event.city!.isNotEmpty) {
        filteredFreelancers = filteredFreelancers
            .where((freelancer) => freelancer.city == event.city)
            .toList();
      }

      // Filter by hourly rate if selected
      if (event.hourlyRates.isNotEmpty) {
        filteredFreelancers = filteredFreelancers.where((freelancer) {
          final hourlyRate =
              currentState.avgHourlyRateMap[freelancer.freelancerId] ?? 0;
          return event.hourlyRates.any((selectedRange) =>
              _isFreelancerInHourlyRateRange(hourlyRate, selectedRange));
        }).toList();
      }

      //Filter by rating if selected
      if (event.rating != null && event.rating! > 0) {
        filteredFreelancers = filteredFreelancers.where((freelancer) {
          final rating =
              currentState.avgRatingMap[freelancer.freelancerId] ?? 0;
          return rating >= event.rating!;
        }).toList();
      }

      emit(SearchLoaded(filteredFreelancers, currentState.portfolioMap,
          currentState.avgHourlyRateMap, currentState.avgRatingMap,
          selectedCity: event.city,
          selectedHourlyRate: event.hourlyRates.join(", "),
          selectedRating: event.rating));
    }
  }

  bool _isFreelancerInHourlyRateRange(int hourlyRate, String selectedRange) {
    switch (selectedRange) {
      case "< Rs. 1000":
        return hourlyRate < 1000;
      case "Rs. 1000 - Rs. 2000":
        return hourlyRate >= 1000 && hourlyRate <= 2000;
      case "Rs. 2000 - Rs. 3000":
        return hourlyRate >= 2000 && hourlyRate <= 3000;
      case "Rs. 3000 - Rs. 4000":
        return hourlyRate >= 3000 && hourlyRate <= 4000;
      case "Rs. 4000 - Rs. 5000":
        return hourlyRate >= 4000 && hourlyRate <= 5000;
      case "> Rs. 5000":
        return hourlyRate > 5000 && hourlyRate <= 100000;
      default:
        return true; // No filtering if range is invalid
    }
  }
}
