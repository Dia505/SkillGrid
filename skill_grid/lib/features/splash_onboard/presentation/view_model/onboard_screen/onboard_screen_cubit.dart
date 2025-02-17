import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view_model/sign_up/client/client_bloc.dart';

class OnboardScreenCubit extends Cubit<void> {
  final LoginBloc _loginBloc;
  final ClientBloc _clientBloc;

  OnboardScreenCubit({
    required LoginBloc loginBloc,
    required ClientBloc clientBloc
  })  : _loginBloc = loginBloc,
        _clientBloc = clientBloc,
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

  void navigateToRegistrationEvent(BuildContext context, Widget destination) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _clientBloc), 
          BlocProvider.value(value: _loginBloc), 
        ],
        child: destination,
      ),
    ),
  );
}

}
