import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/core/theme/theme_sensor/domain/use_case/get_theme_mode_by_sensor_use_case.dart';
import 'package:skill_grid/core/theme/theme_sensor/presentation/theme_bloc.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';
import 'package:skill_grid/features/review/domain/use_case/save_review_use_case.dart';
import 'package:skill_grid/features/review/presentation/view/review_view.dart';
import 'package:skill_grid/features/review/presentation/view_model/review_bloc.dart';

import '../features/auth/domain/use_case/mock_token_helper.mock.dart';

class MockSaveReviewUseCase extends Mock implements SaveReviewUseCase {}

class MockGetClientByIdUseCase extends Mock implements GetClientByIdUseCase {}

class MockGetThemeModeBySensorUseCase extends Mock
    implements GetThemeModeBySensorUseCase {}

class MockAppointmentEntity extends Mock implements AppointmentEntity {}

class MockFreelancerEntity extends Mock implements FreelancerEntity {}

void main() {
  late MockSaveReviewUseCase mockSaveReviewUseCase;
  late MockGetClientByIdUseCase mockGetClientByIdUseCase;
  late MockTokenHelper tokenHelper;
  late MockGetThemeModeBySensorUseCase mockGetThemeModeBySensorUseCase;

  setUp(() {
    mockSaveReviewUseCase = MockSaveReviewUseCase();
    mockGetClientByIdUseCase = MockGetClientByIdUseCase();
    tokenHelper = MockTokenHelper();
    mockGetThemeModeBySensorUseCase = MockGetThemeModeBySensorUseCase();

    GetIt.instance.registerSingleton<ReviewBloc>(ReviewBloc(
        saveReviewUseCase: mockSaveReviewUseCase,
        tokenHelper: tokenHelper,
        getClientByIdUseCase: mockGetClientByIdUseCase));

    GetIt.instance.registerSingleton<ThemeBloc>(
      ThemeBloc(mockGetThemeModeBySensorUseCase),
    );
  });

  tearDown(() {
    // Clean up the GetIt instance after the test
    GetIt.instance.reset();
  });

  testWidgets("Should have title 'Contracts'", (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<ThemeBloc>(
              create: (context) => GetIt.instance<ThemeBloc>(),
            ),
            BlocProvider<ReviewBloc>(
              create: (context) => GetIt.instance<ReviewBloc>(),
            ),
          ],
          child: ReviewView(
            appointment: MockAppointmentEntity(),
            appointmentPurpose: "test purpose",
            freelancer: MockFreelancerEntity(),
            freelancerFirstName: "test first name",
            freelancerLastName: "test last name",
            freelancerProfileImgPath: "test img",
            profession: "test profession",
          ),
        ),
      ),
    );

    // Find the title
    Finder title = find.text('Contracts');
    expect(title, findsOneWidget);
  });
}
