import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/core/theme/theme_sensor/domain/use_case/get_theme_mode_by_sensor_use_case.dart';
import 'package:skill_grid/core/theme/theme_sensor/presentation/theme_bloc.dart';
import 'package:skill_grid/features/appointment/domain/use_case/get_appointment_by_client_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/client_login_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/update_client_profile_picture_usecase.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/update_client_use_case.dart';
import 'package:skill_grid/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/home_screen_pages/dashboard_sidebar.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/home_screen_pages/home_screen_view.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/dashboard/client_dashboard_cubit.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/home_screen/client_home_bloc.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/sidebar/client_sidebar_bloc.dart';
import 'package:skill_grid/features/profile/presentation/view_model/edit_profile/client_edit_profile_bloc.dart';
import 'package:skill_grid/features/profile/presentation/view_model/profile/client/client_profile_bloc.dart';

import '../features/auth/domain/use_case/mock_token_helper.mock.dart';
import '../features/auth/domain/use_case/mock_token_shared_prefs.mock.dart';

class MockGetClientByIdUseCase extends Mock implements GetClientByIdUseCase {}

class MockGetAppointmentByClientIdUseCase extends Mock
    implements GetAppointmentByClientIdUseCase {}

class MockGetThemeModeBySensorUseCase extends Mock
    implements GetThemeModeBySensorUseCase {}

class MockUpdateClientProfilePictureUsecase extends Mock
    implements UpdateClientProfilePictureUsecase {}

class MockUpdateClientUseCase extends Mock implements UpdateClientUseCase {}

class MockClientLoginUseCase extends Mock implements ClientLoginUseCase {}

class MockClientDashboardCubit extends Mock implements ClientDashboardCubit {}

void main() {
  late MockGetClientByIdUseCase mockGetClientByIdUseCase;
  late MockGetAppointmentByClientIdUseCase mockGetAppointmentByClientIdUseCase;
  late MockTokenHelper tokenHelper;
  late MockGetThemeModeBySensorUseCase mockGetThemeModeBySensorUseCase;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late MockUpdateClientProfilePictureUsecase
      mockUpdateClientProfilePictureUsecase;
  late MockUpdateClientUseCase mockUpdateClientUseCase;
  late MockClientLoginUseCase mockClientLoginUseCase;
  late MockClientDashboardCubit mockClientDashboardCubit;

  setUp(() {
    mockGetClientByIdUseCase = MockGetClientByIdUseCase();
    mockGetAppointmentByClientIdUseCase = MockGetAppointmentByClientIdUseCase();
    tokenHelper = MockTokenHelper();
    mockGetThemeModeBySensorUseCase = MockGetThemeModeBySensorUseCase();
    tokenSharedPrefs = MockTokenSharedPrefs();
    mockUpdateClientProfilePictureUsecase =
        MockUpdateClientProfilePictureUsecase();
    mockUpdateClientUseCase = MockUpdateClientUseCase();
    mockClientLoginUseCase = MockClientLoginUseCase();
    mockClientDashboardCubit = MockClientDashboardCubit();

    GetIt.instance.registerSingleton<ClientHomeBloc>(ClientHomeBloc(
        getClientByIdUseCase: mockGetClientByIdUseCase,
        tokenHelper: tokenHelper,
        getAppointmentByClientIdUseCase: mockGetAppointmentByClientIdUseCase));
    GetIt.instance.registerSingleton<ThemeBloc>(
      ThemeBloc(mockGetThemeModeBySensorUseCase),
    );
    GetIt.instance.registerSingleton<ClientEditProfileBloc>(
        ClientEditProfileBloc(
            getClientByIdUseCase: mockGetClientByIdUseCase,
            tokenHelper: tokenHelper,
            updateClientProfilePictureUsecase:
                mockUpdateClientProfilePictureUsecase,
            updateClientUseCase: mockUpdateClientUseCase));
    GetIt.instance.registerSingleton<ClientProfileBloc>(ClientProfileBloc(
        getClientByIdUseCase: mockGetClientByIdUseCase,
        tokenHelper: tokenHelper,
        clientEditProfileBloc: GetIt.instance<ClientEditProfileBloc>()));
    GetIt.instance.registerSingleton<LoginBloc>(
      LoginBloc(
        clientLoginUseCase: mockClientLoginUseCase,
        clientDashboardCubit: mockClientDashboardCubit,
      ),
    );
    GetIt.instance.registerSingleton<ClientSidebarBloc>(ClientSidebarBloc(
        getClientByIdUseCase: mockGetClientByIdUseCase,
        tokenHelper: tokenHelper,
        clientProfileBloc: GetIt.instance<ClientProfileBloc>(),
        tokenSharedPrefs: tokenSharedPrefs,
        loginBloc: GetIt.instance<LoginBloc>()));
  });
  testWidgets("Should have title", (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MultiBlocProvider(
            providers: [
              BlocProvider<ThemeBloc>(
                create: (context) => GetIt.instance<ThemeBloc>(),
              ),
              BlocProvider<ClientHomeBloc>(
                create: (context) => GetIt.instance<ClientHomeBloc>(),
              ),
              BlocProvider<ClientSidebarBloc>(
                create: (context) => GetIt.instance<ClientSidebarBloc>(),
              ),
            ],
            child: const HomeScreenView(),
          ),
        ),
      ),
    );
    Finder title =
        find.text("Discover exceptional talent tailored to your needs.");
    expect(title, findsOneWidget);
  });
}
