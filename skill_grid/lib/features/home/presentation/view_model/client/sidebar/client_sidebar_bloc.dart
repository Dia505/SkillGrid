import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';
import 'package:skill_grid/features/profile/presentation/view_model/client/profile/client_profile_bloc.dart';

part 'client_sidebar_event.dart';
part 'client_sidebar_state.dart';

class ClientSidebarBloc extends Bloc<ClientSidebarEvent, ClientSidebarState> {
  final GetClientByIdUseCase _getClientByIdUseCase;
  final TokenHelper _tokenHelper;
  final ClientProfileBloc _clientProfileBloc;

  bool _isSidebarClosed = true;

  ClientSidebarBloc({
    required GetClientByIdUseCase getClientByIdUseCase,
    required TokenHelper tokenHelper,
    required ClientProfileBloc clientProfileBloc
  })  : _getClientByIdUseCase = getClientByIdUseCase,
        _tokenHelper = tokenHelper,
        _clientProfileBloc = clientProfileBloc,
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
}
