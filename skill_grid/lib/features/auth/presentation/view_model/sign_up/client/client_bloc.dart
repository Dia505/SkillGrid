import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:skill_grid/core/common/snack_bar/snack_bar.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/register_client_use_case.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final RegisterClientUseCase _registerClientUseCase;

  ClientBloc({
    required RegisterClientUseCase registerClientUseCase
  }): _registerClientUseCase = registerClientUseCase,
      super(ClientState.initial()) {
        on<RegisterClient>(_onRegisterClient);
  }   

  void _onRegisterClient(
    RegisterClient event,
    Emitter<ClientState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _registerClientUseCase.call(CreateClientParams(
      firstName: event.firstName, 
      lastName: event.lastName, 
      mobileNo: event.mobileNo, 
      city: event.city, 
      email: event.email, 
      password: event.password
    ));
    
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showSnackBar(
          context: event.context, 
          message: "Registration Successful"
        );
      }
    );
  }
}