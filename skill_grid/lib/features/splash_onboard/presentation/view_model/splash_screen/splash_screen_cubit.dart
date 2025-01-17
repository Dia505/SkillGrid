import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view/login_screen_view.dart';
import 'package:skill_grid/features/auth/presentation/view_model/login/login_bloc.dart';

class SplashScreenCubit extends Cubit<void> {
  final LoginBloc _loginBloc;

  SplashScreenCubit(this._loginBloc) : super(null);

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _loginBloc,
              child: const LoginScreenView(),
            ),
          ),
        );
      }
    });
  }
}