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

                portfolioResult.fold(
                  (failure) => [],
                  (portfolios) {
                    portfolioImages.addAll(portfolios
                        .map((portfolio) => portfolio.filePath)
                        .toList());
                  },
                );
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
}
