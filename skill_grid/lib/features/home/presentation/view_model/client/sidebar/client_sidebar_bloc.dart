import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';
import 'package:skill_grid/features/profile/presentation/view/client/client_profile_view.dart';

part 'client_sidebar_event.dart';
part 'client_sidebar_state.dart';

class ClientSidebarBloc extends Bloc<ClientSidebarEvent, ClientSidebarState> {
  final GetClientByIdUseCase _getClientByIdUseCase;
  final TokenHelper _tokenHelper;

  bool _isSidebarClosed = true;

  ClientSidebarBloc({
    required GetClientByIdUseCase getClientByIdUseCase,
    required TokenHelper tokenHelper,
  })  : _getClientByIdUseCase = getClientByIdUseCase,
        _tokenHelper = tokenHelper,
        super(ClientSidebarInitial()) {
    on<NavigateToClientProfile>(_onNavigateToClientProfile);
    on<ToggleSidebar>((event, emit) {
      if (_isSidebarClosed) {
        _isSidebarClosed = false;
        print("Sidebar is now open");
        emit(SidebarOpened());
      } else {
        _isSidebarClosed = true;
        print("Sidebar is now closed");
        emit(SidebarClosed());
      }
    });
  }

  Future<void> loadClient() async {
    emit(ClientSidebarLoading()); // Emit loading state first

    try {
      final userId = await _tokenHelper.getUserIdFromToken();
      if (userId == null) {
        emit(const ClientSidebarError("Client id not found"));
        return;
      }

      final Either<Failure, ClientEntity> result =
          await _getClientByIdUseCase(GetClientByIdParams(clientId: userId));

      result.fold(
        (failure) {
          emit(ClientSidebarError(
              failure.message)); // Emit error state with failure message
          print("Error in cubit: ${failure.message}");
        },
        (clientEntity) {
          emit(ClientSidebarLoaded(clientEntity,
              _isSidebarClosed)); // Emit loaded state with client info
          print("Client loaded: ${clientEntity.toString()}");
        },
      );
    } catch (e) {
      emit(ClientSidebarError(
          "Error occurred: $e")); // Emit error if an exception occurs
      print("Exception occurred: $e");
    }
  }

  void _onNavigateToClientProfile(
      NavigateToClientProfile event, Emitter<ClientSidebarState> emit) {
    emit(NavigatingToClientProfile());

    // Navigate to the client profile view
    Navigator.push(
      event.context,
      MaterialPageRoute(builder: (context) => const ClientProfileView()),
    );
  }
}
