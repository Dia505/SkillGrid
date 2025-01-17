import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view_model/join_as_client_freelancer/join_as_client_freelancer_cubit.dart';
import 'package:skill_grid/features/auth/presentation/view_model/login/login_bloc.dart';

part 'onboard_screen_event.dart';

class OnboardScreenCubit extends Cubit<void> {
  final LoginBloc _loginBloc;
  final JoinAsClientFreelancerCubit _asClientFreelancerCubit;

  OnboardScreenCubit({
    required LoginBloc loginBloc,
    required JoinAsClientFreelancerCubit asClientFreelancerCubit,
  })  : _loginBloc = loginBloc,
        _asClientFreelancerCubit = asClientFreelancerCubit,
        super(null);

  void navigateToLoginScreen(BuildContext context, Widget destination) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            BlocProvider.value(value: _loginBloc, child: destination),
      ),
    );
  }

  void navigateJoinAsClientFreelancer(BuildContext context, Widget destination) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
            value: _asClientFreelancerCubit, child: destination),
      ),
    );
  }
}
