import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/common/snack_bar/snack_bar.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/client_login_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/freelancer_use_case/freelancer_login_usec_case.dart';
import 'package:skill_grid/features/auth/presentation/view/join_client_freelancer_view.dart';
import 'package:skill_grid/features/auth/presentation/view_model/join_as_client_freelancer/join_as_client_freelancer_cubit.dart';
import 'package:skill_grid/features/home/presentation/view/client/client_dashboard.dart';
import 'package:skill_grid/features/home/presentation/view/freelancer/freelancer_dashboard.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final JoinAsClientFreelancerCubit _joinAsClientFreelancerCubit;
  final ClientLoginUseCase _clientLoginUseCase;
  final FreelancerLoginUseCase _freelancerLoginUseCase;

  LoginBloc({
    required JoinAsClientFreelancerCubit joinAsClientFreelancerCubit,
    required ClientLoginUseCase clientLoginUseCase,
    required FreelancerLoginUseCase freelancerLoginUseCase,
  })  : _joinAsClientFreelancerCubit = joinAsClientFreelancerCubit,
        _clientLoginUseCase = clientLoginUseCase,
        _freelancerLoginUseCase = freelancerLoginUseCase,
        super(LoginState.initial()) {
    // Navigate to client/freelancer selection screen
    on<NavigateJoinAsClientFreelancerEvent>((event, emit) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _joinAsClientFreelancerCubit,
            child: const JoinClientFreelancerView(),
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
      : await _freelancerLoginUseCase(
          FreelancerLoginParams(email: event.email, password: event.password));

      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, isSuccess: false));
          showSnackBar(
            context: event.context,
            message: "Invalid Credentials",
            color: Colors.red,
          );
        },
        (token) {
          emit(state.copyWith(isLoading: false, isSuccess: true));

          final destination = state.role == 'client'
              ? const ClientDashboard()
              : const FreelancerDashboard();

          add(NavigateHomeScreenEvent(
            context: event.context,
            destination: destination,
          ));
        },
      );
    });
  }
}
