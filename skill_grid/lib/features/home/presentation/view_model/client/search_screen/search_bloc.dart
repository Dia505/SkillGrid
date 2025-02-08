import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/search_freelancers_use_case.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchFreelancersUseCase _searchFreelancersUseCase;

  SearchBloc(
    {required SearchFreelancersUseCase searchFreelancersUseCase}) 
      : _searchFreelancersUseCase = searchFreelancersUseCase,
        super(SearchInitial()) {
    on<SearchFreelancers>(_onSearchFreelancers);
  }

  Future<void> _onSearchFreelancers(
    SearchFreelancers event,
    Emitter<SearchState> emit
  ) async {
    emit(SearchLoading());

    final result = await _searchFreelancersUseCase(SearchFreelancersParams(searchQuery: event.searchQuery));

    result.fold(
      (failure) {
        emit(SearchError(failure.message));
      }, 
      (freelancers) {
        emit(SearchLoaded(freelancers));
      }
    );
  }
}