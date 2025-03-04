import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/core/theme/theme_sensor/domain/use_case/get_theme_mode_by_sensor_use_case.dart';
import 'package:skill_grid/core/theme/theme_sensor/presentation/theme_bloc.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/client_login_use_case.dart';
import 'package:skill_grid/features/auth/presentation/view/login_screen_view.dart';
import 'package:skill_grid/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/dashboard/client_dashboard_cubit.dart';

class MockClientLoginUseCase extends Mock implements ClientLoginUseCase {}

class MockClientDashboardCubit extends Mock implements ClientDashboardCubit {}

class MockGetThemeModeBySensorUseCase extends Mock
    implements GetThemeModeBySensorUseCase {}

void main() {
  late MockClientLoginUseCase mockClientLoginUseCase;
  late MockClientDashboardCubit mockClientDashboardCubit;
  late MockGetThemeModeBySensorUseCase mockGetThemeModeBySensorUseCase;

  setUp(() {
    mockClientLoginUseCase = MockClientLoginUseCase();
    mockClientDashboardCubit = MockClientDashboardCubit();
    mockGetThemeModeBySensorUseCase = MockGetThemeModeBySensorUseCase();

    GetIt.instance
        .registerSingleton<MockClientLoginUseCase>(mockClientLoginUseCase);
    GetIt.instance
        .registerSingleton<MockClientDashboardCubit>(mockClientDashboardCubit);
    GetIt.instance.registerSingleton<LoginBloc>(
      LoginBloc(
        clientLoginUseCase: mockClientLoginUseCase,
        clientDashboardCubit: mockClientDashboardCubit,
      ),
    );
    GetIt.instance.registerSingleton<ThemeBloc>(
      ThemeBloc(mockGetThemeModeBySensorUseCase),
    );
  });

  tearDown(() {
    // Reset GetIt after the test
    GetIt.instance.reset();
  });

  testWidgets("Should have title 'Welcome Back!'", (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MultiBlocProvider(
            providers: [
              BlocProvider<ThemeBloc>(
                create: (context) => GetIt.instance<ThemeBloc>(),
              ),
              BlocProvider<LoginBloc>(
                create: (context) => GetIt.instance<LoginBloc>(),
              ),
            ],
            child: const LoginScreenView(),
          ),
        ),
      ),
    );

    // Your test assertions go here
    Finder title = find.text("Welcome Back!");
    expect(title, findsOneWidget);
  });

  testWidgets("User can input text in fields", (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MultiBlocProvider(
            providers: [
              BlocProvider<ThemeBloc>(
                create: (context) => GetIt.instance<ThemeBloc>(),
              ),
              BlocProvider<LoginBloc>(
                create: (context) => GetIt.instance<LoginBloc>(),
              ),
            ],
            child: const LoginScreenView(),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField).at(0), 'testuser@gmail.com');
    expect(find.byType(TextField).at(0), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(1), 'Testuser@123');
    expect(find.byType(TextField).at(1), findsOneWidget);
  });
}
