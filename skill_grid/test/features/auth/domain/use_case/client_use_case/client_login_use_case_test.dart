import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/client_login_use_case.dart';

import '../mock_token_shared_prefs.dart';
import 'mock_client_repository.dart';

void main() {
  late MockClientRepository repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late ClientLoginUseCase useCase;

  setUp(() {
    repository = MockClientRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    useCase = ClientLoginUseCase(repository, tokenSharedPrefs);

    when(() => tokenSharedPrefs.getToken())
      .thenAnswer((_) async => const Right("token"));
  });

  test(
      "Should call [ClientRepository.loginClient] with correct email and password (test@gmail.com, Test@123)",
      () async {
    when(() => repository.loginClient(any(), any()))
        .thenAnswer((invocation) async {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;

      if (email == "test@gmail.com" && password == "Test@123") {
        return Future.value(const Right("token"));
      } else {
        return Future.value(
            const Left(ApiFailure(message: "Invalid email or password")));
      }
    });

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    final result = await useCase(
        const ClientLoginParams(email: "test@gmail.com", password: "Test@123"));

    expect(result, const Right("token"));

    verify(() => repository.loginClient(any(), any())).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);
    verify(() => tokenSharedPrefs.getToken()).called(1);

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });

  tearDown(() {
    reset(repository);
    reset(tokenSharedPrefs);
  });
}
