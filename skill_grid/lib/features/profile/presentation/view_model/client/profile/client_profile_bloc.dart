import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';
import 'package:skill_grid/features/profile/presentation/view/client/client_profile_edit_view.dart';

part 'client_profile_state.dart';
part 'client_profile_event.dart';

class ClientProfileBloc extends Bloc<ClientProfileEvent, ClientProfileState> {
  final GetClientByIdUseCase _getClientByIdUseCase;
  final TokenHelper _tokenHelper;

  ClientProfileBloc(
      {required GetClientByIdUseCase getClientByIdUseCase,
      required TokenHelper tokenHelper})
      : _getClientByIdUseCase = getClientByIdUseCase,
        _tokenHelper = tokenHelper,
        super(ClientProfileInitial()) {
          on<NavigateToEditClientProfile>(_onNavigateToEditClientProfile);
        }

  Future<void> loadClient() async {
    emit(ClientProfileLoading());

    try {
      final userId = await _tokenHelper.getUserIdFromToken();
      if (userId == null) {
        emit(const ClientProfileError("Client id not found"));
        return;
      }

      final Either<Failure, ClientEntity> result =
          await _getClientByIdUseCase(GetClientByIdParams(clientId: userId));

      result.fold(
        (failure) {
          emit(ClientProfileError(failure.message));
          print("Error in cubit: ${failure.message}");
        },
        (clientEntity) {
          emit(ClientProfileLoaded(clientEntity));
          print("Client loaded: ${clientEntity.toString()}");
        },
      );
    } catch (e) {
      emit(ClientProfileError("Error occurred: $e"));
      print("Exception occurred: $e");
    }
  }

  void _onNavigateToEditClientProfile(
      NavigateToEditClientProfile event, Emitter<ClientProfileState> emit) {
    emit(NavigatingToEditClientProfile());

    // Navigate to the client profile view
    Navigator.push(
      event.context,
      MaterialPageRoute(builder: (context) => const ClientProfileEditView()),
    );
  }
}