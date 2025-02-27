import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/app/di/di.dart';
import 'package:skill_grid/core/theme/app_theme.dart';
import 'package:skill_grid/core/theme/theme_sensor/presentation/theme_bloc.dart';
import 'package:skill_grid/features/splash_onboard/presentation/view/splash_screen_view.dart';
import 'package:skill_grid/features/splash_onboard/presentation/view_model/splash_screen/splash_screen_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final themeBloc = getIt<ThemeBloc>();
        themeBloc.add(StartAmbientTheme()); 
        return themeBloc;
      },
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: getApplicationTheme(isDarkMode: state.isDarkMode),
            home: BlocProvider.value(
              value: getIt<SplashScreenCubit>(),
              child: const SplashScreenView(),
            ),
          );
        },
      ),
    );
  }
}
