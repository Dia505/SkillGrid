import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/common/snack_bar/snack_bar.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/register_client_use_case.dart';
import 'package:skill_grid/features/auth/presentation/view_model/login/login_bloc.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final RegisterClientUseCase _registerClientUseCase;
  final LoginBloc _loginBloc;

  ClientBloc({
    required RegisterClientUseCase registerClientUseCase,
    required LoginBloc loginBloc,
  })  : _registerClientUseCase = registerClientUseCase,
        _loginBloc = loginBloc,
        super(ClientState.initial()) {
    on<RegisterClient>(_onRegisterClient);

    on<NavigateToLoginScreen>((event, emit) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) =>
              BlocProvider.value(value: _loginBloc, child: event.destination),
        ),
      );
    });
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
        password: event.password));

    result.fold((l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (r) {
      emit(state.copyWith(isLoading: false, isSuccess: true));
      showSnackBar(context: event.context, message: "Registration Successful");
    });
  }
}
