import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/features/splash_onboard/presentation/view/onboard_screen_view.dart';
import 'package:skill_grid/features/splash_onboard/presentation/view_model/onboard_screen/onboard_screen_cubit.dart';

class SplashScreenCubit extends Cubit<void> {
  final OnboardScreenCubit _onboardScreenCubit;

  SplashScreenCubit(this._onboardScreenCubit) : super(null);

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _onboardScreenCubit,
              child: const OnboardScreenView(),
            ),
          ),
        );
      }
    });
  }
}