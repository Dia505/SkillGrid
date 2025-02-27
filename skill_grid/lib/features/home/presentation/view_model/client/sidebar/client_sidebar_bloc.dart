import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';
import 'package:skill_grid/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:skill_grid/features/profile/presentation/view_model/profile/client/client_profile_bloc.dart';

part 'client_sidebar_event.dart';
part 'client_sidebar_state.dart';

class ClientSidebarBloc extends Bloc<ClientSidebarEvent, ClientSidebarState> {
  final GetClientByIdUseCase _getClientByIdUseCase;
  final TokenHelper _tokenHelper;
  final ClientProfileBloc _clientProfileBloc;
  final TokenSharedPrefs _tokenSharedPrefs;
  final LoginBloc _loginBloc;

  bool _isSidebarClosed = true;

  ClientSidebarBloc({
    required GetClientByIdUseCase getClientByIdUseCase,
    required TokenHelper tokenHelper,
    required ClientProfileBloc clientProfileBloc,
    required TokenSharedPrefs tokenSharedPrefs,
    required LoginBloc loginBloc
  })  : _getClientByIdUseCase = getClientByIdUseCase,
        _tokenHelper = tokenHelper,
        _clientProfileBloc = clientProfileBloc,
        _tokenSharedPrefs = tokenSharedPrefs,
        _loginBloc = loginBloc,
        super(ClientSidebarInitial()) {
    on<NavigateToClientProfile>((event, emit) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) =>
              BlocProvider.value(
                value: _clientProfileBloc, 
                child: event.destination
              ),
        ),
      );
    });
    on<ToggleSidebar>((event, emit) {
      if (_isSidebarClosed) {
        _isSidebarClosed = false;
        emit(SidebarOpened());
      } else {
        _isSidebarClosed = true;
        emit(SidebarClosed());
      }
    });

    on<LogOutEvent>((event, emit) async {
      emit(ClientSidebarLoading());

      try {
        final result = await _tokenSharedPrefs.removeToken();

        result.fold(
          (failure) {
            emit(ClientSidebarError("Failed to log out: ${failure.message}"));
            print("Logout failed: ${failure.message}");
          },
          (_) {
            emit(LoggedOut());

            Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                    value: _loginBloc,
                    child: event.destination,
                  )));
          }
        );
      }
      catch(e) {
        emit(ClientSidebarError("Error during logout: $e"));
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
              failure.message)); 
        },
        (clientEntity) {
          emit(ClientSidebarLoaded(clientEntity,
              _isSidebarClosed)); 
        },
      );
    } catch (e) {
      emit(ClientSidebarError(
          "Error occurred: $e")); // Emit error if an exception occurs
      print("Exception occurred: $e");
    }
  }
}
