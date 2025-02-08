import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/app/di/di.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/search_freelancers_use_case.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/search_screen_pages/search_screen_view.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/search_screen/search_bloc.dart';

part 'client_home_event.dart';
part 'client_home_state.dart';

class ClientHomeBloc extends Bloc<ClientHomeEvent, ClientHomeState> {
  final GetClientByIdUseCase _getClientByIdUseCase;
  final TokenHelper _tokenHelper;
  final SearchFreelancersUseCase _searchFreelancersUseCase;

  ClientHomeBloc(
      {required GetClientByIdUseCase getClientByIdUseCase,
      required TokenHelper tokenHelper,
      required SearchFreelancersUseCase searchFreelancersUseCase})
      : _getClientByIdUseCase = getClientByIdUseCase,
        _tokenHelper = tokenHelper,
        _searchFreelancersUseCase = searchFreelancersUseCase,
        super(ClientHomeInitial()) {
    on<SearchFreelancers>(_onSearchFreelancers);

    on<NavigateToSearchScreenEvent>(_onNavigateToSearchScreen);
  }

  Future<void> loadClient() async {
    emit(ClientHomeLoading());

    try {
      final userId = await _tokenHelper.getUserIdFromToken();
      if (userId == null) {
        emit(const ClientHomeError("Client id not found"));
        return;
      }

      final Either<Failure, ClientEntity> result =
          await _getClientByIdUseCase(GetClientByIdParams(clientId: userId));

      result.fold(
        (failure) {
          emit(ClientHomeError(failure.message));
          print("Error in cubit: ${failure.message}");
        },
        (clientEntity) {
          emit(ClientHomeLoaded(clientEntity));
          print("Client loaded: ${clientEntity.toString()}");
        },
      );
    } catch (e) {
      emit(ClientHomeError("Error occurred: $e"));
      print("Exception occurred: $e");
    }
  }

  Future<void> _onSearchFreelancers(
      SearchFreelancers event, Emitter<ClientHomeState> emit) async {
    emit(ClientHomeSearchLoading());

    final result = await _searchFreelancersUseCase(
        SearchFreelancersParams(searchQuery: event.searchQuery));

    result.fold((failure) {
      emit(ClientHomeSearchError(failure.message));
    }, (freelancers) {
      emit(ClientHomeSearchLoaded(freelancers));
      add(NavigateToSearchScreenEvent(
        context: event.context, 
        destination: const SearchScreenView()
      ));
    });
  }

  Future<void> _onNavigateToSearchScreen(NavigateToSearchScreenEvent event, Emitter<ClientHomeState> emit) async {
    Navigator.pushReplacement(
      event.context,
      MaterialPageRoute(
        builder: (context) =>
            BlocProvider.value(value: this, child: event.destination), // Pass the bloc to the new screen
      ),
    );
  }
}
