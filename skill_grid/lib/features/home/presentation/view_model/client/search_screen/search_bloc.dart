import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/search_freelancers_use_case.dart';
import 'package:skill_grid/features/portfolio/domain/use_case/get_portfolio_by_freelancer_id_use_case.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchFreelancersUseCase _searchFreelancersUseCase;
  // final GetPortfolioByFreelancerIdUseCase _getPortfolioByFreelancerIdUseCase;

  SearchBloc(
      {required SearchFreelancersUseCase searchFreelancersUseCase,
      // required GetPortfolioByFreelancerIdUseCase
      //     getPortfolioByFreelancerIdUseCase
      })
      : _searchFreelancersUseCase = searchFreelancersUseCase,
        // _getPortfolioByFreelancerIdUseCase = getPortfolioByFreelancerIdUseCase,
        super(SearchInitial()) {
    on<SearchFreelancers>(_onSearchFreelancers);
  }

  Future<void> _onSearchFreelancers(
      SearchFreelancers event, Emitter<SearchState> emit) async {
    emit(SearchLoading());

    final result = await _searchFreelancersUseCase(
        SearchFreelancersParams(searchQuery: event.searchQuery));

    result.fold((failure) {
      emit(SearchError(failure.message));
    }, (freelancers) {
      emit(SearchLoaded(freelancers));
    });
  }
}
