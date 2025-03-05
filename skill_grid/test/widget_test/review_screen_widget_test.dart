import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/core/common/common_button.dart';
import 'package:skill_grid/core/theme/theme_sensor/domain/use_case/get_theme_mode_by_sensor_use_case.dart';
import 'package:skill_grid/core/theme/theme_sensor/presentation/theme_bloc.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
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

class MockClientEntity extends Mock implements ClientEntity {}

class FakeGetClientByIdParams extends Fake implements GetClientByIdParams {}

void main() {
  late MockSaveReviewUseCase mockSaveReviewUseCase;
  late MockGetClientByIdUseCase mockGetClientByIdUseCase;
  late MockTokenHelper tokenHelper;
  late MockGetThemeModeBySensorUseCase mockGetThemeModeBySensorUseCase;

  setUpAll(() {
    registerFallbackValue(FakeGetClientByIdParams());
  });

  setUp(() {
    mockSaveReviewUseCase = MockSaveReviewUseCase();
    mockGetClientByIdUseCase = MockGetClientByIdUseCase();
    tokenHelper = MockTokenHelper();
    when(() => tokenHelper.getUserIdFromToken())
        .thenAnswer((_) async => "mock_user_id");
    mockGetThemeModeBySensorUseCase = MockGetThemeModeBySensorUseCase();

    // ✅ Add this mock setup to avoid 'Null' error
    when(() => mockGetClientByIdUseCase(any()))
        .thenAnswer((_) async => Right(MockClientEntity()));

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

  testWidgets("Should have title 'Review'", (WidgetTester tester) async {
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
    Finder title = find.text('Review');
    expect(title, findsOneWidget);
  });

  testWidgets('Star rating updates when tapped', (WidgetTester tester) async {
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

    // Tap the 4th star (index 3) and verify rating update
    await tester.tap(find.byIcon(Icons.star).at(3));
    await tester.pump();

    // Check if the selected rating has updated
    final selectedStars = tester
        .widgetList<Icon>(find.byIcon(Icons.star))
        .where((icon) => icon.color == Colors.amber)
        .length;

    expect(selectedStars,
        4); // Since indexes start from 0, selecting index 3 means rating = 4
  });

  testWidgets('Text input field updates when user types',
      (WidgetTester tester) async {
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

    // Find the text input field
    final textField = find.byType(TextFormField);

    // Enter text into the field
    await tester.enterText(textField, 'Great work!');

    // Ensure the entered text is present
    expect(find.text('Great work!'), findsOneWidget);
  });

  testWidgets('form validation shows *required when review is empty',
      (tester) async {
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

    // Find the review text field and "Send" button
    final sendButton = find.text('Send');

    // Tap the "Send" button without entering anything in the review field
    await tester.tap(sendButton);
    await tester.pump(); // Rebuild the widget after the button tap

    // Check if the "*required" validation message is displayed
    expect(find.text('*required'), findsOneWidget);

    // Instead of checking the button type, verify its interaction
    expect(find.byType(CommonButton), findsOneWidget);

    // Check that the button is not disabled
    final sendButtonWidget = tester.widget<CommonButton>(find.byType(CommonButton));
    expect(sendButtonWidget.onPressed, isNotNull);
  });
}
