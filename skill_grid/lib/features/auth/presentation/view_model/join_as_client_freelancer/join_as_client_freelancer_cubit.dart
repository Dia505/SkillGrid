import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view/client_registration_view.dart';
import 'package:skill_grid/features/auth/presentation/view/freelancer_registration_view.dart';
import 'package:skill_grid/features/auth/presentation/view/login_screen_view.dart';
import 'package:skill_grid/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view_model/sign_up/client/client_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view_model/sign_up/freelancer/freelancer_bloc.dart';
import 'join_as_client_freelancer_state.dart';

class JoinAsClientFreelancerCubit extends Cubit<JoinAsClientFreelancerState> {
  final ClientBloc _clientBloc;
  final FreelancerBloc _freelancerBloc;
  final LoginBloc _loginBloc;

  JoinAsClientFreelancerCubit({
    required ClientBloc clientBloc,
    required FreelancerBloc freelancerBloc,
    required LoginBloc loginBloc
  }) :_clientBloc = clientBloc,
      _freelancerBloc = freelancerBloc,
      _loginBloc = loginBloc,
      super(JoinAsClientFreelancerState());

  void selectClient() {
    emit(JoinAsClientFreelancerState(selectedRole: UserRole.client));
  }

  void selectFreelancer() {
    emit(JoinAsClientFreelancerState(selectedRole: UserRole.freelancer));
  }

  void navigateBasedOnRole(BuildContext context) {
    final role = state.selectedRole;
    if (role == UserRole.client) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _clientBloc,
            child: const ClientRegistrationView(),
          )
        ),
      );
    } else if (role == UserRole.freelancer) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _freelancerBloc,
            child: const FreelancerRegistrationView(),
          )
        ),
      );
    }
  }

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: _loginBloc,
          child: const LoginScreenView(),
        )
      )
    );
  }
}
