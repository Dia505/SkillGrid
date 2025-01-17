import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/app/di/di.dart';
import 'package:skill_grid/core/common/snack_bar/snack_bar.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/client_login_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/freelancer_login_usec_case.dart';
import 'package:skill_grid/features/auth/presentation/view_model/join_as_client_freelancer/join_as_client_freelancer_cubit.dart';
import 'package:skill_grid/features/auth/presentation/view_model/sign_up/client/client_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view_model/sign_up/freelancer/freelancer_bloc.dart';
import 'package:skill_grid/features/home/presentation/view/client/client_dashboard.dart';
import 'package:skill_grid/features/home/presentation/view/freelancer/freelancer_dashboard.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ClientLoginUseCase _clientLoginUseCase;
  final FreelancerLoginUseCase _freelancerLoginUseCase;

  LoginBloc({
    required ClientLoginUseCase clientLoginUseCase,
    required FreelancerLoginUseCase freelancerLoginUseCase,
  })  : _clientLoginUseCase = clientLoginUseCase,
        _freelancerLoginUseCase = freelancerLoginUseCase,
        super(LoginState.initial()) {
          
    // Navigate to client/freelancer selection screen
    on<NavigateJoinAsClientFreelancerEvent>((event, emit) {
      final joinAsClientFreelancerCubit = getIt<JoinAsClientFreelancerCubit>();
      final clientBloc = getIt<ClientBloc>();
      final freelancerBloc = getIt<FreelancerBloc>();
      final loginBloc = getIt<LoginBloc>();

      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: joinAsClientFreelancerCubit),
              BlocProvider.value(value: clientBloc),
              BlocProvider.value(value: freelancerBloc),
              BlocProvider.value(value: loginBloc),
            ],
            child: event.destination,
          ),
        ),
      );
    });

    // Handle navigation to the home screen based on role
    on<NavigateHomeScreenEvent>((event, emit) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => event.destination,
        ),
      );
    });

    on<LoginUserEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final result = (state.role == 'client')
          ? await _clientLoginUseCase(
              ClientLoginParams(email: event.email, password: event.password))
          : await _freelancerLoginUseCase(FreelancerLoginParams(
              email: event.email, password: event.password));

      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, isSuccess: false));
          String errorMessage = failure.message ?? "Invalid Credentials";
          showSnackBar(
            context: event.context,
            message: errorMessage,
            color: Colors.red,
          );
        },
        (token) {
          emit(state.copyWith(isLoading: false, isSuccess: true));

          // Add NavigateHomeScreenEvent here to navigate to the appropriate dashboard
          add(NavigateHomeScreenEvent(
            context: event.context,
            destination: state.role == 'client'
                ? const ClientDashboard()
                : const FreelancerDashboard(),
          ));
        },
      );
    });
  }
}
