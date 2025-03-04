import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/features/splash_onboard/presentation/view/splash_screen_view.dart';
import 'package:skill_grid/features/splash_onboard/presentation/view_model/splash_screen/splash_screen_cubit.dart';

// Create a fake for BuildContext.
class FakeBuildContext extends Fake implements BuildContext {}

// Create a mock class for SplashCubit.
class MockSplashCubit extends Mock implements SplashScreenCubit {}

void main() {
  // Register fallback values for BuildContext and MaterialPageRoute.
  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
    registerFallbackValue(MaterialPageRoute(builder: (_) => Container()));
  });

  late SplashScreenCubit splashCubit;

  // A helper function that wraps SplashView with MaterialApp and BlocProvider.
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<SplashScreenCubit>.value(
        value: splashCubit,
        child: const SplashScreenView(),
      ),
    );
  }

  setUp(() {
    splashCubit = MockSplashCubit();
    // Stub the stream getter to return an empty stream.
    when(() => splashCubit.stream).thenAnswer((_) => const Stream.empty());
    // Stub the init method so that it doesn't try to perform navigation.
    when(() => splashCubit.init(any())).thenAnswer((_) async {});
  });

  testWidgets('should display the logo image with correct asset path',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    // Verify that an Image widget is found.
    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);

    // Verify that the Image widget uses the correct asset.
    final Image imageWidget = tester.widget(imageFinder);
    expect(imageWidget.image, isA<AssetImage>());
    final AssetImage assetImage = imageWidget.image as AssetImage;
    expect(
        assetImage.assetName, equals('assets/images/splash_screen_logo.png'));
  });
}
