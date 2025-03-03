import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/core/theme/theme_sensor/domain/use_case/get_theme_mode_by_sensor_use_case.dart';
import 'package:skill_grid/core/theme/theme_sensor/presentation/theme_bloc.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/client_login_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/register_client_use_case.dart';
import 'package:skill_grid/features/auth/presentation/view/client_registration_view.dart';
import 'package:skill_grid/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:skill_grid/features/auth/presentation/view_model/sign_up/client/client_bloc.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/dashboard/client_dashboard_cubit.dart';

// Mock classes
class MockRegisterClientUseCase extends Mock implements RegisterClientUseCase {}

class MockClientLoginUseCase extends Mock implements ClientLoginUseCase {}

class MockClientDashboardCubit extends Mock implements ClientDashboardCubit {}

class MockGetThemeModeBySensorUseCase extends Mock
    implements GetThemeModeBySensorUseCase {}

void main() {
  late MockRegisterClientUseCase mockRegisterClientUseCase;
  late MockClientLoginUseCase mockClientLoginUseCase;
  late MockClientDashboardCubit mockClientDashboardCubit;
  late MockGetThemeModeBySensorUseCase mockGetThemeModeBySensorUseCase;

  setUp(() {
    // Initialize mocks
    mockRegisterClientUseCase = MockRegisterClientUseCase();
    mockClientLoginUseCase = MockClientLoginUseCase();
    mockClientDashboardCubit = MockClientDashboardCubit();
    mockGetThemeModeBySensorUseCase = MockGetThemeModeBySensorUseCase();

    // Register mock dependencies in GetIt
    GetIt.instance.registerSingleton<MockRegisterClientUseCase>(
        mockRegisterClientUseCase);
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
    GetIt.instance.registerSingleton<ClientBloc>(
      ClientBloc(
        loginBloc: GetIt.instance<LoginBloc>(),
        registerClientUseCase: mockRegisterClientUseCase,
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

  testWidgets("Should have title 'Sign up'", (WidgetTester tester) async {
    // Set a custom screen size for testing
    tester.view.physicalSize = const Size(1200, 800); // Larger screen
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        home: SizedBox(
          width: 500, // Match the larger screen size
          height: 300,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<ThemeBloc>(
                create: (context) => GetIt.instance<ThemeBloc>(),
              ),
              BlocProvider<ClientBloc>(
                create: (context) => GetIt.instance<ClientBloc>(),
              ),
            ],
            child: const ClientRegistrationView(),
          ),
        ),
      ),
    );

    // Your test assertions go here
    Finder title = find.text("Sign Up");
    expect(title, findsOneWidget);
  });
}
