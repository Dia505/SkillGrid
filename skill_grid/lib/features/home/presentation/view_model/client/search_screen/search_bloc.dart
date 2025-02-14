import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/search_freelancers_use_case.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';
import 'package:skill_grid/features/freelancer_service/domain/use_case/get_freelancer_service_by_freelancer_id_use_case.dart';
import 'package:skill_grid/features/portfolio/domain/use_case/get_portfolio_by_freelancer_service_id_use_case.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchFreelancersUseCase _searchFreelancersUseCase;
  final GetPortfolioByFreelancerServiceIdUseCase
      _getPortfolioByFreelancerServiceIdUseCase;
  final GetFreelancerServiceByFreelancerIdUseCase
      _getFreelancerSerivceByFreelancerIdUseCase;

  SearchBloc(
      {required SearchFreelancersUseCase searchFreelancersUseCase,
      required GetPortfolioByFreelancerServiceIdUseCase
          getPortfolioByFreelancerServiceIdUseCase,
      required GetFreelancerServiceByFreelancerIdUseCase
          getFreelancerSerivceByFreelancerIdUseCase})
      : _searchFreelancersUseCase = searchFreelancersUseCase,
        _getPortfolioByFreelancerServiceIdUseCase =
            getPortfolioByFreelancerServiceIdUseCase,
        _getFreelancerSerivceByFreelancerIdUseCase =
            getFreelancerSerivceByFreelancerIdUseCase,
        super(SearchInitial()) {
    on<SearchFreelancers>(_onSearchFreelancers);
    on<FilterByCriteria>(_onFilterByCriteria);
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

        for (var freelancer in freelancers) {
          final freelancerServices =
              await _getFreelancerSerivceByFreelancerIdUseCase(
                  GetFreelancerServiceByFreelancerIdParams(
                      freelancerId: freelancer.freelancerId!));

          await freelancerServices.fold(
            (failure) async => 0,
            (services) async {
              final averageHourlyRate = _calculateAverageHourlyRate(services);
              avgHourlyRateMap[freelancer.freelancerId!] = averageHourlyRate;

              List<String> portfolioImages = [];
              for (var service in services) {
                final portfolioResult =
                    await _getPortfolioByFreelancerServiceIdUseCase(
                        GetPortfolioByFreelancerServiceIdParams(
                            freelancerServiceId: service.freelancerServiceId!));

                await portfolioResult.fold((failure) async => 0,
                    (portfolio) async {
                  portfolioImages.addAll(portfolio.filePath);
                });
              }

              portfolioMap[freelancer.freelancerId!] = portfolioImages;
            },
          );
        }

        emit(SearchLoaded(freelancers, portfolioMap, avgHourlyRateMap));
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
        return event.hourlyRates.any(
            (selectedRange) => _isFreelancerInHourlyRateRange(hourlyRate, selectedRange));
      }).toList();
    }

      print("Filtered: $filteredFreelancers");
      print("Filtered count: ${filteredFreelancers.length}");
      print(
          "Emitting SearchLoaded with ${filteredFreelancers.length} freelancers");

      emit(SearchLoaded(
        filteredFreelancers,
        currentState.portfolioMap,
        currentState.avgHourlyRateMap,
        selectedCity: event.city,
        selectedHourlyRate: event.hourlyRates.join(", "),
      ));
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
