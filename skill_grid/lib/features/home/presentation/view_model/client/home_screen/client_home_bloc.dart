import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/appointment/domain/use_case/get_appointment_by_client_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/search_freelancers_use_case.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/search_screen_pages/search_screen_view.dart';

part 'client_home_event.dart';
part 'client_home_state.dart';

class ClientHomeBloc extends Bloc<ClientHomeEvent, ClientHomeState> {
  bool homeLoaded = false;
  final GetClientByIdUseCase _getClientByIdUseCase;
  final TokenHelper _tokenHelper;
  final SearchFreelancersUseCase _searchFreelancersUseCase;
  final GetAppointmentByClientIdUseCase _getAppointmentByClientIdUseCase;

  ClientHomeBloc({
    required GetClientByIdUseCase getClientByIdUseCase,
    required TokenHelper tokenHelper,
    required SearchFreelancersUseCase searchFreelancersUseCase,
    required GetAppointmentByClientIdUseCase getAppointmentByClientIdUseCase,
  })  : _getClientByIdUseCase = getClientByIdUseCase,
        _tokenHelper = tokenHelper,
        _searchFreelancersUseCase = searchFreelancersUseCase,
        _getAppointmentByClientIdUseCase = getAppointmentByClientIdUseCase,
        super(ClientHomeInitial()) {
    on<SearchFreelancers>(_onSearchFreelancers);

    on<NavigateToSearchScreenEvent>(_onNavigateToSearchScreen);

    on<FetchClientContracts>((event, emit) async {
      try {
        // Fetch the contracts for the client using the provided client ID
        final contractsResult = await _getAppointmentByClientIdUseCase(
            GetAppointmentByClientIdParams(clientId: event.clientId));

        contractsResult.fold(
          (failure) {
            // If there's a failure, emit error state
            emit(ClientHomeError(failure.message));
          },
          (contracts) {
            // If contracts are fetched successfully, emit the loaded state
            emit(HomeContractsLoadedState(contracts));
          },
        );
      } catch (e) {
        // Handle any other errors and emit error state
        emit(ClientHomeError("Error occurred while fetching contracts: $e"));
      }
    });
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
        },
        (clientEntity) {
          emit(ClientHomeLoaded(clientEntity));
          homeLoaded = true;
          if (state is! HomeContractsLoadedState) {
            add(FetchClientContracts(clientId: userId));
            emit(ClientHomeLoaded(clientEntity));
          }
        },
      );
    } catch (e) {
      emit(ClientHomeError("Error occurred: $e"));
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
          context: event.context, destination: const SearchScreenView()));
    });
  }

  Future<void> _onNavigateToSearchScreen(
      NavigateToSearchScreenEvent event, Emitter<ClientHomeState> emit) async {
    Navigator.pushReplacement(
      event.context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
            value: this,
            child: event.destination), // Pass the bloc to the new screen
      ),
    );
  }
}
