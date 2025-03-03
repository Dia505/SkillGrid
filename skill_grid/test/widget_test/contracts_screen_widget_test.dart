import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/core/theme/theme_sensor/domain/use_case/get_theme_mode_by_sensor_use_case.dart';
import 'package:skill_grid/core/theme/theme_sensor/presentation/theme_bloc.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/appointment/domain/use_case/get_appointment_by_client_id_use_case.dart';
import 'package:skill_grid/features/home/presentation/view/client/dashboard_pages/contract_screen_pages/client_contracts_view.dart';
import 'package:skill_grid/features/home/presentation/view_model/client/contracts_view_model/contracts/contracts_bloc.dart';
import 'package:skill_grid/features/payment/domain/entity/payment_entity.dart';
import 'package:skill_grid/features/payment/domain/use_case/get_payment_by_appointment_id_use_case.dart';

import '../features/auth/domain/use_case/mock_token_helper.mock.dart';

// Mock class
class MockGetThemeModeBySensorUseCase extends Mock
    implements GetThemeModeBySensorUseCase {}

class MockGetAppointmentByClientIdUseCase extends Mock
    implements GetAppointmentByClientIdUseCase {}

class MockGetPaymentByAppointmentIdUseCase extends Mock
    implements GetPaymentByAppointmentIdUseCase {}

class MockContractsBloc extends Mock implements ContractsBloc {}

class MockAppointmentEntity extends Mock implements AppointmentEntity {}

class MockPaymentEntity extends Mock implements PaymentEntity {}

void main() {
  late MockGetThemeModeBySensorUseCase mockGetThemeModeBySensorUseCase;
  late MockGetAppointmentByClientIdUseCase mockGetAppointmentByClientIdUseCase;
  late MockGetPaymentByAppointmentIdUseCase
      mockGetPaymentByAppointmentIdUseCase;
  late MockTokenHelper tokenHelper;

  setUp(() {
    mockGetThemeModeBySensorUseCase = MockGetThemeModeBySensorUseCase();
    mockGetAppointmentByClientIdUseCase = MockGetAppointmentByClientIdUseCase();
    mockGetPaymentByAppointmentIdUseCase =
        MockGetPaymentByAppointmentIdUseCase();
    tokenHelper = MockTokenHelper();

    GetIt.instance.registerSingleton<ThemeBloc>(
      ThemeBloc(mockGetThemeModeBySensorUseCase),
    );

    GetIt.instance.registerSingleton<ContractsBloc>(ContractsBloc(
        getAppointmentByClientIdUseCase: mockGetAppointmentByClientIdUseCase,
        tokenHelper: tokenHelper,
        getPaymentByAppointmentIdUseCase:
            mockGetPaymentByAppointmentIdUseCase));
  });

  tearDown(() {
    // Clean up the GetIt instance after the test
    GetIt.instance.reset();
  });

  testWidgets("Should have title 'Contracts'", (WidgetTester tester) async {
    // Mock the ContractsBloc state
    final mockContractsBloc = MockContractsBloc();

    final mockAppointments = [
      MockAppointmentEntity(), // Mock an AppointmentEntity object
      MockAppointmentEntity(), // Add more mock appointments as needed
    ];
    final mockPayments = [
      MockPaymentEntity(),
      MockPaymentEntity()
    ];

    // Mock ContractsBloc behavior
    whenListen(
      mockContractsBloc,
      Stream.fromIterable([
        ContractsLoadedState(mockAppointments, mockPayments)
      ]),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<ThemeBloc>(
              create: (context) => GetIt.instance<ThemeBloc>(),
            ),
            BlocProvider<ContractsBloc>(
              create: (context) => GetIt.instance<ContractsBloc>(),
            ),
          ],
          child: const ClientContractsView(),
        ),
      ),
    );

    // Find the title
    Finder title = find.text('Contracts');
    expect(title, findsOneWidget);
  });
}
