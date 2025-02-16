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
import 'package:skill_grid/features/home/presentation/view_model/client/dashboard/client_dashboard_cubit.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/home_screen/client_home_bloc.dart';
import 'package:skill_grid/features/home/presentation/view_model/freelancer/freelancer_dashboard_cubit.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ClientLoginUseCase _clientLoginUseCase;
  final FreelancerLoginUseCase _freelancerLoginUseCase;
  final ClientDashboardCubit _clientDashboardCubit;
  final FreelancerDashboardCubit _freelancerDashboardCubit;

  LoginBloc({
    required ClientLoginUseCase clientLoginUseCase,
    required FreelancerLoginUseCase freelancerLoginUseCase,
    required ClientDashboardCubit clientDashboardCubit,
    required FreelancerDashboardCubit freelancerDashboardCubit,
  })  : _clientLoginUseCase = clientLoginUseCase,
        _freelancerLoginUseCase = freelancerLoginUseCase,
        _clientDashboardCubit = clientDashboardCubit,
        _freelancerDashboardCubit = freelancerDashboardCubit,
        super(LoginState.initial()) {
    // 🔹 Navigate to client/freelancer selection screen
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

    // 🔹 Handle role-based home screen navigation
    on<NavigateHomeScreenEvent>((event, emit) {
      Widget destinationWidget;

      if (event.role == 'client') {
        destinationWidget = BlocProvider<ClientDashboardCubit>.value(
          value: _clientDashboardCubit,
          child: const ClientDashboard(),
        );
      } else {
        destinationWidget = BlocProvider<FreelancerDashboardCubit>.value(
          value: _freelancerDashboardCubit,
          child: const FreelancerDashboard(),
        );
      }

      Navigator.pushAndRemoveUntil(
        event.context,
        MaterialPageRoute(builder: (context) => destinationWidget),
        (route) => false,
      );
    });

    //Login User Event
    on<LoginUserEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, isSuccess: false));

      //First try client login
      final clientResult = await _clientLoginUseCase(
        ClientLoginParams(email: event.email, password: event.password),
      );
      print("Client Login Result: $clientResult");

      if (clientResult.isRight()) {
        clientResult
            .getOrElse(() => throw Exception("Unexpected null user"));
        print("Login success. User role: client");

        emit(state.copyWith(isLoading: false, isSuccess: true, role: 'client'));

        final clientHomeBloc = getIt<ClientHomeBloc>();
        clientHomeBloc.loadClient();

        add(NavigateHomeScreenEvent(
          context: event.context,
          destination: const ClientDashboard(),
          role: 'client',
        ));
        return;
      }

      //If client login fails, try freelancer login
      final freelancerResult = await _freelancerLoginUseCase(
        FreelancerLoginParams(email: event.email, password: event.password),
      );
      print("Freelancer Login Result: $freelancerResult");

      if (freelancerResult.isRight()) {
        freelancerResult
            .getOrElse(() => throw Exception("Unexpected null user"));
        print("Login success. User role: freelancer");

        emit(state.copyWith(
            isLoading: false, isSuccess: true, role: 'freelancer'));

        add(NavigateHomeScreenEvent(
          // ignore: use_build_context_synchronously
          context: event.context,
          destination: const FreelancerDashboard(),
          role: 'freelancer',
        ));
        return;
      }

      // 🔹 If both fail, show an error message
      print("Login failed for both client and freelancer.");
      emit(state.copyWith(isLoading: false, isSuccess: false));

      showSnackBar(
        context: event.context,
        message: "Invalid credentials. Please check your email and password.",
        color: Colors.red,
      );
    });
  }
}
