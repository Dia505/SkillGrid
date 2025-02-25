import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/app/di/di.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/core/common/snack_bar/snack_bar.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/client_login_use_case.dart';
import 'package:skill_grid/features/auth/presentation/view_model/send_otp/send_otp_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view_model/sign_up/client/client_bloc.dart';
import 'package:skill_grid/features/home/presentation/view/client/client_dashboard.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/dashboard/client_dashboard_cubit.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ClientLoginUseCase _clientLoginUseCase;
  final ClientDashboardCubit _clientDashboardCubit;
  final TokenSharedPrefs _tokenSharedPrefs;

  LoginBloc(
      {required ClientLoginUseCase clientLoginUseCase,
      required ClientDashboardCubit clientDashboardCubit,
      required TokenSharedPrefs tokenSharedPrefs})
      : _clientLoginUseCase = clientLoginUseCase,
        _clientDashboardCubit = clientDashboardCubit,
        _tokenSharedPrefs = tokenSharedPrefs,
        super(LoginState.initial()) {
    on<NavigateToRegistrationEvent>((event, emit) {
      final clientBloc = getIt<ClientBloc>();
      final loginBloc = getIt<LoginBloc>();

      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: clientBloc),
              BlocProvider.value(value: loginBloc),
            ],
            child: event.destination,
          ),
        ),
      );
    });

    on<NavigateToSendOtpScreen>((event, emit) {
      final sendOtpBloc = getIt<SendOtpBloc>();

      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [BlocProvider.value(value: sendOtpBloc)],
            child: event.destination,
          ),
        ),
      );
    });

    on<NavigateHomeScreenEvent>((event, emit) {
      Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                    value: _clientDashboardCubit,
                    child: event.destination,
                  )));
    });

    //Login User Event
    on<LoginUserEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, isSuccess: false));

      final result = await _clientLoginUseCase(
          ClientLoginParams(email: event.email, password: event.password));

      result.fold((failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));

        showSnackBar(
          context: event.context,
          message: "Invalid credentials. Please check your email and password.",
          color: Colors.red,
        );
      }, (token) async {
        emit(state.copyWith(isLoading: false, isSuccess: true));

        add(NavigateHomeScreenEvent(
            context: event.context, destination: const ClientDashboard()));
      });
    });
  }
}
