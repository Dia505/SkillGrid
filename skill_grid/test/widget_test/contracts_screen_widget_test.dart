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
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';
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

class MockContractsBloc extends Mock implements ContractsBloc {
  @override
  Future<void> loadClientContracts() async {
    // Mock behavior: either complete immediately or simulate a delay
    return Future.value();
  }
}

// Mock class for PaymentEntity
class MockPaymentEntity extends Mock implements PaymentEntity {
  @override
  AppointmentEntity get appointment =>
      MockAppointmentEntity(); // Mock the appointment property
}

class MockFreelancerServiceEntity extends Mock
    implements FreelancerServiceEntity {}

class MockClientEntity extends Mock implements ClientEntity {}

class MockAppointmentEntity extends Mock implements AppointmentEntity {
  @override
  String get appointmentId => '1'; // Mocking the appointmentId
  @override
  String get appointmentPurpose =>
      'Design Project'; // Mocking the appointmentPurpose
  @override
  DateTime get appointmentDate =>
      DateTime(2025, 1, 1); // Mocking the appointmentDate
  @override
  ProjectDuration get projectDuration => const ProjectDuration(
      value: 30, unit: 'days'); // Mocking project duration
  @override
  DateTime? get projectEndDate =>
      DateTime(2025, 2, 1); // Mocking project end date
  @override
  String? get appointmentTime => '10:00 AM'; // Mocking appointment time
  @override
  bool get status => true; // Mocking status
  @override
  FreelancerServiceEntity get freelancerService =>
      MockFreelancerServiceEntity(); // Mocking FreelancerServiceEntity
  @override
  ClientEntity get client => MockClientEntity(); // Mocking ClientEntity
}

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
      getPaymentByAppointmentIdUseCase: mockGetPaymentByAppointmentIdUseCase,
    ));
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  testWidgets("Should have title 'Contracts'", (WidgetTester tester) async {
    // Create mock instances for appointment and payment entities
    final mockAppointments = [
      MockAppointmentEntity(),
      MockAppointmentEntity(),
    ];
    final mockPayments = [MockPaymentEntity(), MockPaymentEntity()];

    // Create and configure the mock ContractsBloc
    final mockContractsBloc = MockContractsBloc();

    // Stub the ContractsBloc's stream to return the ContractsLoadedState with mocked data
    whenListen(
      mockContractsBloc,
      Stream<ContractsState>.fromIterable(
        [ContractsLoadedState(mockAppointments, mockPayments)],
      ),
      initialState: ContractsLoadedState(mockAppointments, mockPayments),
    );

    // Set up the widget test environment
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MultiBlocProvider(
            providers: [
              BlocProvider<ThemeBloc>(
                create: (context) => GetIt.instance<ThemeBloc>(),
              ),
              BlocProvider<ContractsBloc>(
                create: (context) =>
                    mockContractsBloc, // Use mocked ContractsBloc
              ),
            ],
            child: const ClientContractsView(),
          ),
        ),
      ),
    );

    // Allow the widget tree to settle after the widget is built
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Verify that the 'Contracts' title is found in the widget tree
    expect(find.text('Contracts'), findsOneWidget);
  });
}
