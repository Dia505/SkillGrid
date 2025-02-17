import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:skill_grid/app/shared_prefs/token_shared_prefs.dart';
import 'package:skill_grid/features/home/presentation/view/client/client_dashboard.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/dashboard/client_dashboard_cubit.dart';
import 'package:skill_grid/features/splash_onboard/presentation/view/onboard_screen_view.dart';
import 'package:skill_grid/features/splash_onboard/presentation/view_model/onboard_screen/onboard_screen_cubit.dart';

class SplashScreenCubit extends Cubit<void> {
  final OnboardScreenCubit _onboardScreenCubit;
  final ClientDashboardCubit _clientDashboardCubit;

  SplashScreenCubit(this._onboardScreenCubit, this._clientDashboardCubit) : super(null);

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        final tokenSharedPrefs = GetIt.instance<TokenSharedPrefs>();
        final result = await tokenSharedPrefs.getToken();
        
        result.fold(
          (failure) {
            // Handle failure if needed (e.g., log error, show toast)
            print(failure.message);
            _navigateToOnboardingScreen(context);
          },
          (token) {
            if (token.isNotEmpty) {
              _navigateToClientDashboard(context);
            } else {
              _navigateToOnboardingScreen(context);
            }
          },
        );
      }
    });
  }

  void _navigateToClientDashboard(BuildContext context) {
    Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _clientDashboardCubit,
              child: const ClientDashboard(),
            ),
          ),
        );
  }

  // Navigate to the Login Screen
  void _navigateToOnboardingScreen(BuildContext context) {
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
}